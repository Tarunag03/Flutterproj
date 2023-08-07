import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: const Icon(
          Icons.facebook_outlined,
          size: 60,
        ),
      ),
    );
  }
}
