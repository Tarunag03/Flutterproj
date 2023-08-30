import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Friendreq extends StatefulWidget {
  const Friendreq({super.key});
  @override
  State<StatefulWidget> createState() {
    return _FriendreqState();
  }
}

class _FriendreqState extends State<Friendreq> {
  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> displayedUsers = [];
  bool isLoading = true;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchUsers();
  }

  void getCurrentUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    currentUserId = user?.uid ?? '';
  }

  void fetchUsers() async {
    final usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    final List<Map<String, dynamic>> users = usersSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    setState(() {
      isLoading = false;
      allUsers = users;
      displayedUsers = users;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Usernames"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: searchUsers,
                decoration: InputDecoration(
                  labelText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: displayedUsers.length,
                    itemBuilder: (context, index) {
                      final username = displayedUsers[index]['username'];
                      final uid = displayedUsers[index]['uid'];

                      if (uid == currentUserId) {
                        return Container();
                      }

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.pinkAccent[100],
                          child: Text(
                            username[0].toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.person_add),
                          onPressed: () {
                            sendFriendRequest(username, uid);
                          },
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
