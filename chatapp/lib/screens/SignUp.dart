import 'package:chatapp/screens/login.dart';
import 'package:chatapp/widgets/AuthSignupForm.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/AuthCircleContainer.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_plus/icons_plus.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
            child: Column(
              children: [
                const Text(
                  'SignUp Now',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 193, 95, 210)),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Please Registration with email and sign up to continue using our app',
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Enter via Socail Network',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthContainer(
                      icon: FontAwesomeIcons.google,
                      auth: "gopgle",
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    AuthContainer(
                      icon: FontAwesome.phone,
                      auth: "phone",
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    AuthContainer(icon: FontAwesomeIcons.github, auth: ""),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'or SignUp with email',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Expanded(
                  child: AuthSignUpForm(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'You Already Have Account ?',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child:
                          const Text('LogIn', style: TextStyle(fontSize: 15)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
