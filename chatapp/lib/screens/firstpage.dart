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
    void logout() async {
      await GoogleSignIn().disconnect();
      FirebaseAuth.instance.signOut();

      Navigator.pop(context);
    }

    return Center(
      child: Column(
        children: [
          Text('Welcome'),
          ElevatedButton(onPressed: logout, child: Text('Logout'))
        ],
      ),
    );
  }
}
