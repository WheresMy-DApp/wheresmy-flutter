import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:http/http.dart' as http;
import 'package:wheresmy/models/user.dart';
import 'package:wheresmy/utils/constants.dart';
import 'package:wheresmy/utils/logger.dart';
import 'package:wheresmy/widgets/snackbar.dart';

import 'package:wheresmy/providers/web3_provider.dart';

enum AuthStatus { authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  SessionStatus? sessionStatus;
  String? token;
  User? currentUser;
  AuthStatus authStatus = AuthStatus.unauthenticated;

  static AuthProvider instance = AuthProvider();

  AuthProvider();

  Future<String?> register(String walletId) async {
    try {
      http.Response response =
          await http.post(Uri.parse("${AppConstants.host}/user/initLogin"),
              headers: {
                "Content-Type": "application/json",
                "device": Platform.isIOS ? "ios" : "android",
              },
              body: jsonEncode({
                "walletAddress": walletId,
              }));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data["message"];
      } else if (response.statusCode == 401) {
        SnackBarService.instance
            .showFailureSnackBar("You are already registered");
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<String?> initLogin() async {
    try {
      Web3Provider.instance.createWalletSession();
      http.Response response = await http.post(
        Uri.parse("${AppConstants.host}/user/initLogin"),
        headers: {
          "Content-Type": "application/json",
          "device": Platform.isIOS ? "ios" : "android",
        },
        body: jsonEncode({
          "walletAddress": Web3Provider.instance.walletId,
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data["message"];
      } else if (response.statusCode == 401) {
        SnackBarService.instance.showFailureSnackBar("User not found");
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<String?> signMessage(String message) async {
    if (!Web3Provider.instance.connector.connected) {
      await Web3Provider.instance.createWalletSession();
    }
    var signature = await Web3Provider.instance.signMessage(message);
    if (signature != null) {
      return signature;
    } else {
      return null;
    }
  }

  Future<void> login(String signature) async {
    try {
      http.Response response = await http.post(
        Uri.parse("${AppConstants.host}/user/login"),
        headers: {
          "Content-Type": "application/json",
          "device": "ios",
        },
        body: jsonEncode({
          "walletAddress": Web3Provider.instance.walletId,
          "signature": signature,
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        token = data["token"];
        currentUser = User.fromJson(data["user"]);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token!);
        authStatus = AuthStatus.authenticated;
        notifyListeners();
      }
    } catch (e) {
      log.severe(e);
    }
  }
}
