import 'dart:developer';

import 'package:chatapp/screens/login.dart';
import 'package:chatapp/services/fetchparticularuser.dart';
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Fetch user id'),
        actions: [
          ElevatedButton(
            onPressed: () {
              logout(context);
            },
            child: Text('Logout'),
            style: ElevatedButton.styleFrom(
             
            ),
          )
        ],
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: currentUser != null && currentUser.uid != null
          ? FirestoreFetchUserScreen(userUid: currentUser.uid)
          : Center(child: Text('User not authenticated')),
      backgroundColor: Colors.white, 
    );
  }
}
