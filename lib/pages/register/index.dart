import 'package:flutter/material.dart';
import 'package:wheresmy/widgets/custom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
              "Register",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "Hey there, nice to meet you!",
              style: Theme.of(context).textTheme.headline5,
            ),
            _registrationProgressionTab(),
            customTextFormField(emailController, "Email address"),
            customTextFormField(passwordController, "Password",
                suffixIcon: Icons.visibility_off, isObscure: true),
            customTextFormField(confirmPasswordController, "Confirm password",
                suffixIcon: Icons.visibility_off, isObscure: true),
            SizedBox(
              width: 343,
              height: 56,
              child: customButton(
                "Next(1/3)",
                onTap: () {},
              ),
            ),
            Text(
              "Already have an account? Sign In",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _registrationProgressionTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _progressionTab(Icons.person_rounded, "Basic Details"),
        _progressionTab(Icons.wallet, "Link Wallet"),
        _progressionTab(Icons.login, "Login"),
      ],
    );
  }

  Widget _progressionTab(IconData iconData, String text) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF191919),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
