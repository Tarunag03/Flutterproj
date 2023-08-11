import 'dart:developer';

import 'package:chatapp/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class firstpage extends StatelessWidget {
  const firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {
      GoogleSignIn().disconnect();
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.signOut().then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text('Welcome screen'),
          const SizedBox(
            width: 125,
          ),
          ElevatedButton(onPressed: logout, child: Icon(Icons.logout_sharp)),
        ]),
      ),
    );
  }
}
