import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class AuthProvider extends ChangeNotifier {
  String? walletId;
  WalletConnect connector = WalletConnect(
    bridge: "https://bridge.walletconnect.org",
    clientMeta: const PeerMeta(
      name: "Where's My",
      description: "An app for keeping track of your devices",
      url: "https://wheresmy.network",
    ),
  );
  SessionStatus? sessionStatus;

  static AuthProvider instance = AuthProvider();

  AuthProvider();

  Future<void> createWalletSession() async {
    if (!connector.connected) {
      sessionStatus = await connector.createSession(
        onDisplayUri: (uri) async {
          await launchUrlString(
            uri,
            mode: LaunchMode.externalApplication,
          );
        },
      );
      walletId = sessionStatus!.accounts[0];
      notifyListeners();
    }
  }

  Future<String?> signMessage(String message) async {
    connector = WalletConnect(
      bridge: "https://bridge.walletconnect.org",
      clientMeta: const PeerMeta(
        name: "Where's My",
        description: "An app for keeping track of your devices",
        url: "https://wheresmy.network",
      ),
    );
    var signature = await connector.sendCustomRequest(
      method: "personal_sign",
      params: [
        message,
        walletId,
      ],
    );
    return signature as String?;
  }
}
