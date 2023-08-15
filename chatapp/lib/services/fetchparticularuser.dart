import 'package:chatapp/widgets/reuable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirestoreFetchUserScreen extends StatefulWidget {
  final String userUid;

  FirestoreFetchUserScreen({required this.userUid});

  @override
  _FirestoreFetchUserScreenState createState() => _FirestoreFetchUserScreenState();
}

class _FirestoreFetchUserScreenState extends State<FirestoreFetchUserScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> userDocument;

  @override
  void initState() {
    super.initState();
    userDocument = FirebaseFirestore.instance.collection('users').doc(widget.userUid).get();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 4),
                 
                 
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue, 
                  ),
                  
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: userDocument,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return Text('User not found.');
                      } else {
                        Map<String, dynamic> userData = snapshot.data!.data()!;
                        String username = userData['username'] ?? 'N/A';
                        String email = userData['email'] ?? 'N/A';

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              SizedBox(height: MediaQuery.of(context).size.height / 14),
                            reusableTextField(username, Icons.verified_user, false, controller),
                            SizedBox(height: MediaQuery.of(context).size.height / 38),
                            reusableTextField(email, Icons.email, false, controller),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, 
    );
  }
}
