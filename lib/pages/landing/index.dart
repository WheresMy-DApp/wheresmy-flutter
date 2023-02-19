import 'package:flutter/material.dart';
import 'package:wheresmy/services/navigation_service.dart';
import 'package:wheresmy/widgets/custom.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 343,
                height: 432,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF49DEDE),
                      Color(0xFF85FFFF),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Image.asset(
                  "assets/logos/landingCard.png",
                  width: double.infinity,
                ),
              ),
              SizedBox(
                child: Column(
                  children: const [
                    Text(
                      "Let's Start!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 49,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "Track all your devices in one place",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 270,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 99,
                      height: 56,
                      child: customButton(
                        "Register",
                        isFilled: false,
                        onTap: () {
                          NavigationService.instance.navigateTo("register");
                        },
                      ),
                    ),
                    SizedBox(
                      width: 99,
                      height: 56,
                      child: customButton(
                        "Sign In",
                        onTap: () {
                          NavigationService.instance.navigateTo("sign_in");
                        },
                      ),
                    ),
                    // For Testing only
                    // SizedBox(
                    //   width: 25,
                    //   height: 56,
                    //   child: customButton(
                    //     "Go to Test Page",
                    //     onTap: () {
                    //       NavigationService.instance.navigateTo("home");
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
