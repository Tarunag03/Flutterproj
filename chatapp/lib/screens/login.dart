import 'package:chatapp/widgets/AuthCircleContainer.dart';
import 'package:chatapp/widgets/AuthLoginForm.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_plus/icons_plus.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
          child: Column(
            children: [
              const Text(
                'LogIn Now',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 193, 95, 210)),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Please login to continue Namaste app',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 70,
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
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AuthContainer(
                    icon: FontAwesome.twitter,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AuthContainer(
                    icon: FontAwesomeIcons.github,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Expanded(child: AuthLoginForm()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a member ?',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: () {},
                    child: const Text('Register Now',
                        style: TextStyle(fontSize: 16)),
                    onFocusChange: (value) => null,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
