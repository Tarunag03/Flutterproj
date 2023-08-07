import 'package:chatapp/widgets/AuthCircleContainer.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.white,
      child: SizedBox(
        child: Padding(
          child: const Column(
            children: [
              Text(
                'LogIn Now',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 193, 95, 210)),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Please login to continue Namaste app',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 80,
              ),
              Text('Enter via Socail Network'),
              Row(
                children: [
                  const AuthContainer(),
                ],
              )
            ],
          ),
          padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
        ),
      ),
    );
  }
}
