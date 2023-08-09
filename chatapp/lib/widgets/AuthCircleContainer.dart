import 'package:chatapp/screens/PhoneAuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthContainer extends StatefulWidget {
  const AuthContainer({super.key, required this.icon, required this.auth});

  final IconData icon;
  final String auth;
  @override
  State<AuthContainer> createState() {
    return _AuthContainerState();
  }
}

class _AuthContainerState extends State<AuthContainer> {
  void _changeScreen() {
    if (widget.auth == "phone") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PhoneAuthScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _changeScreen,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.all(15),
        child: FaIcon(
          widget.icon,
          size: 45,
        ),
      ),
    );
  }
}
