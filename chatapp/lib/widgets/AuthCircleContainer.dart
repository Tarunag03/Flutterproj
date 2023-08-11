import 'package:chatapp/screens/PhoneAuthScreen.dart';
import 'package:chatapp/screens/firstpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chatapp/widgets/GitSecretKey.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
//..

  googleLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();

      if (reslut == null) {
        return;
      }

      final userData = await reslut.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      print(credential);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
  }

  void newuser() async {
    await googleLogin();
    if (mounted) {
      // Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => firstpage()));
    } else {
      return;
    }
  }

  void _changeScreen() async {
    if (widget.auth == "phone") {
      print('yes phone here');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PhoneAuthScreen(),
        ),
      );
    }
    if (widget.auth == "google") {
      newuser();
    }
    if (widget.auth == "github") {
      print("github");
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
