import 'package:cloud_firestore/cloud_firestore.dart';

bool isProfileComplete(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  if (snapshot.exists) {
  
    return true;
  }
  return false;
}
