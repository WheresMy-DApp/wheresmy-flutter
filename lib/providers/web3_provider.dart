import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:wheresmy/utils/ethereum_credentials.dart';

class Web3Provider extends ChangeNotifier {
  String? walletId;
  EthereumWalletConnectProvider? provider;
  WalletConnectEthereumCredentials? credentials;
  WalletConnect connector = WalletConnect(
    bridge: "https://bridge.walletconnect.org",
    clientMeta: const PeerMeta(
      name: "Where's My",
      description: "An app for keeping track of your devices",
      url: "https://wheresmy.network",
    ),
  );
  SessionStatus? sessionStatus;
  String? launchUri;

  static Web3Provider instance = Web3Provider();
  Web3Provider();

  Future<void> clearAllSessions() async {
    connector.killSession();
  }

  Future<void> createWalletSession() async {
    if (!connector.connected) {
      sessionStatus = await connector.createSession(
        onDisplayUri: (uri) async {
          launchUri = uri;
          await launchUrlString(
            uri,
            mode: LaunchMode.externalApplication,
          );
        },
      );
      provider = EthereumWalletConnectProvider(connector);
      credentials = WalletConnectEthereumCredentials(provider: provider!);
      walletId = sessionStatus!.accounts[0];
      notifyListeners();
    }
  }

  Future<String?> signMessage(String message) async {
    if (!connector.connected) {
      await createWalletSession();
    }
    await launchUrlString(launchUri!, mode: LaunchMode.externalApplication);
    var signature = await connector.sendCustomRequest(
        method: "personal_sign", params: [message, walletId]);
    return signature;
  }
}
