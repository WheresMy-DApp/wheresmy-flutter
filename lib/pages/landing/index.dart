import 'package:flutter/material.dart';

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
                      child: _customButton(
                        "Register",
                        isFilled: false,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      width: 99,
                      height: 56,
                      child: _customButton(
                        "Sign In",
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _customButton(String text,
      {required Function() onTap, bool isFilled = true}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border:
                isFilled ? null : Border.all(color: const Color(0xFFF3F3F3)),
            borderRadius: BorderRadius.circular(10),
            gradient: isFilled
                ? const LinearGradient(
                    colors: <Color>[
                      Color(0xFF9C77F5),
                      Color(0xFF7751F1),
                    ],
                  )
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFF3F3F3),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
