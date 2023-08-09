import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.all(15),
        child: FaIcon(
          icon,
          size: 45,
        ),
      ),
    );
  }
}
