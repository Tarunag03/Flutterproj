import 'package:chatapp/services/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/ProfileCompleteScreen.dart';
import '../screens/firstpage.dart';

void checkProfileAndNavigate(User user, BuildContext context) async {
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
  bool profilecomplete = isProfileComplete(snapshot);
  print("profilecomple: $profilecomplete");
  if (isProfileComplete(snapshot)) {
    print('i am in if part');
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => firstpage(userUid: user.uid,)),
    );
  } else {
    print('yes i am here');
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfileCompleteScreen()),
    );
  }
}
