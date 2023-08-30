import 'dart:developer';

import 'package:chatapp/screens/login.dart';
import 'package:chatapp/services/fetchparticularuser.dart';
import 'package:chatapp/widgets/SideNavigationBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class firstpage extends StatelessWidget {
  firstpage({super.key, required this.userUid});
  final String userUid;
  void logout(BuildContext context) async {
    GoogleSignIn().disconnect();
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? currentUser = _auth.currentUser;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1, right: 30, top: 15),
                  child: Text(
                    'Namaste',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    left: 40,
                  ),
                  child: Text(
                    'connecting zindagi.....',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                logout(context);
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(),
            )
          ],
          backgroundColor: Colors.pinkAccent[100],
        ),
        body: const SideNavigationBarComponent(),
      ),
    );
  }
}
