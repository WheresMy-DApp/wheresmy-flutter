import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:wheresmy/providers/auth_provider.dart';
import 'package:wheresmy/services/navigation_service.dart';
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

  late int _currentStep;

  String? message;

  @override
  void initState() {
    _currentStep = 1;
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
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: _renderBox(),
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

  // Progression tab

  Widget _registrationProgressionTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // _progressionTab(Icons.person_rounded, "Basic Details"),
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

  // Central Content

  Widget _renderBox() {
    switch (_currentStep) {
      case 0:
        return _step1();
      case 1:
        return _step2();
      case 2:
        return _step3();
      default:
        return Container();
    }
  }

  Widget _step1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
            onTap: () {
              setState(() {
                _currentStep = 1;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _step2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/logos/metamask_large.png",
          width: 86.87,
          height: 80,
        ),
        SizedBox(
          width: 275,
          height: 54,
          child: customButton(
            "Connect To Metamask",
            onTap: () async {
              await AuthProvider.instance.createWalletSession();
              message = await AuthProvider.instance
                  .register(AuthProvider.instance.walletId!);
              setState(() {
                _currentStep = 2;
              });
            },
            isFilled: false,
            textColor: const Color(0xFFFBDD66),
          ),
        ),
      ],
    );
  }

  Widget _step3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        customTextFormField(emailController, "Email address"),
        customTextFormField(passwordController, "Password",
            suffixIcon: Icons.visibility_off, isObscure: true),
        SizedBox(
          width: 275,
          height: 54,
          child: customButton(
            "Next (3/3)",
            onTap: () async {
              if (message != null) {
                var signature =
                    await AuthProvider.instance.signMessage(message!);
                print(signature);
              }
            },
          ),
        ),
      ],
    );
  }
}
