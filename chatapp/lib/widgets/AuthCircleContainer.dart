import 'package:chatapp/screens/PhoneAuthScreen.dart';
import 'package:chatapp/screens/ProfileCompleteScreen.dart';
import 'package:chatapp/screens/firstpage.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/widgets/reuable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> googleLogin() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuth =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }

    return null;
  }



void newuser() async {
  UserCredential? userCredential = await googleLogin();
  if (userCredential != null) {
    String? uid = userCredential.user?.uid;
    String? username = userCredential.user?.displayName;
    String? email = userCredential.user?.email;

    if (uid != null) {
      // Store user data in Firebase Firestore
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'uid':uid,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => firstpage(userUid: uid)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
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
