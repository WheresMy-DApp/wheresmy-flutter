import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            Row(
              children: [
                Container(
                  child: const Center(
                    child: Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
