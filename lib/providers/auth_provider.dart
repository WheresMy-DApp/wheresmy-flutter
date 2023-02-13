import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:http/http.dart' as http;
import 'package:wheresmy/utils/constants.dart';

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
  String? launchUri;

  static AuthProvider instance = AuthProvider();

  AuthProvider();

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
      walletId = sessionStatus!.accounts[0];
      notifyListeners();
    }
  }

  Future<String?> register(String walletId) async {
    try {
      http.Response response =
          await http.post(Uri.parse("${AppConstants.host}/user/register"),
              headers: {
                "Content-Type": "application/json",
              },
              body: jsonEncode({
                "walletAddress": walletId,
              }));
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data["message"];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> signMessage(String message) async {
    if (!connector.connected) {
      await createWalletSession();
    }
    await launchUrlString(launchUri!, mode: LaunchMode.externalApplication);
    var signature = await connector.sendCustomRequest(
        method: "personal_sign", params: [message, walletId]);
    if (signature != null) {
      return signature;
    } else {
      return null;
    }
  }
}
