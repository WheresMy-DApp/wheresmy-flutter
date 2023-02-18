import 'package:flutter/material.dart';
import 'package:wheresmy/providers/auth_provider.dart';
import 'package:wheresmy/providers/web3_provider.dart';
import 'package:wheresmy/services/navigation_service.dart';
import 'package:wheresmy/widgets/custom.dart';
import 'package:wheresmy/widgets/snackbar.dart';

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
    SnackBarService.instance.context = context;

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
            // customTextFormField(
            //   emailTextController,
            //   "Email Address",
            // ),
            // customTextFormField(
            //   passwordTextController,
            //   "Password",
            //   suffixIcon: Icons.visibility,
            //   isObscure: true,
            // ),
            // SizedBox(
            //   height: 56,
            //   child: customButton(
            //     "Continue",
            //     onTap: () {},
            //   ),
            // ),
            // Row(
            //   children: [
            //     const Expanded(
            //       child: Divider(
            //         color: Color(
            //           0xFF393939,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       margin: const EdgeInsets.only(
            //         left: 10,
            //         right: 10,
            //       ),
            //       child: const Text("or"),
            //     ),
            //     const Expanded(
            //       child: Divider(
            //         color: Color(
            //           0xFF393939,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 56,
              child: customButton(
                "Sign in with Metamask",
                onTap: () async {
                  await Web3Provider.instance.createWalletSession();
                  var message = await AuthProvider.instance.initLogin();
                  if (message != null) {
                    var signature =
                        await AuthProvider.instance.signMessage(message);
                    if (signature != null) {
                      await AuthProvider.instance.login(signature);
                      if (AuthProvider.instance.authStatus ==
                          AuthStatus.authenticated) {
                        NavigationService.instance
                            .navigateToReplacement("home");
                      }
                    }
                  }
                },
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
