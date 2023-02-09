// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wheresmy/pages/landing/index.dart';
import 'package:wheresmy/widgets/custom.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  @override
  void initState() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00078dce),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                "assets/logos/small.png",
              ),
              width: 50.23,
              alignment: Alignment.center,
            ),
            Text(
              "Sign In",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "Welcome back, we missed you!",
              style: Theme.of(context).textTheme.headline5,
            ),
            customTextFormField(
              emailTextController,
              "Email Address",
            ),
            customTextFormField(
              passwordTextController,
              "Password",
              suffixIcon: Icons.visibility,
              isObscure: true,
            ),
            SizedBox(
              height: 56,
              child: customButton(
                "Continue",
                onTap: () {},
              ),
            ),
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Color(
                      0xFF393939,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: const Text("or"),
                ),
                const Expanded(
                  child: Divider(
                    color: Color(
                      0xFF393939,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 56,
              child: customButton(
                "Sign in with Metamask",
                onTap: () {},
                isFilled: false,
              ),
            ),
            Text(
              "Don't have an account? Sign Up",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
