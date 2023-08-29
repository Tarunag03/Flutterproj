import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactScreen(),
    );
  }
}

final userDocument = FirebaseFirestore.instance.collection('users');

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key, required this.userUid}) : super(key: key);
  final String userUid;
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> displayedUsers = [];
  TextEditingController searchController = TextEditingController();
  IconData initialLetterIcon = Icons.person;
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

  void sendFriendRequest(String username, String friendUid) async {
    final chatRoomId = generateChatRoomId();

    final friendRequest = {
      'icon': initialLetterIcon.codePoint,
      'username': username,
      'chatRoomId': chatRoomId,
    };

    final currentUserRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserId);

    await currentUserRef.update({
      'friendRequests': FieldValue.arrayUnion([friendRequest]),
    });

    print('Friend request sent to $username');
  }

  String generateChatRoomId() {
    return 'chat_room_${Random().nextInt(10000)}';
  }

  void searchUsers(String query) {
    List<Map<String, dynamic>> searchResults = [];

    if (query.isNotEmpty) {
      searchResults = allUsers.where((user) {
        return user['username'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      searchResults = List.from(allUsers);
    }

    setState(() {
      displayedUsers = searchResults;
    });
  }

  @override
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
                  prefixIcon: const Icon(Icons.search),
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
