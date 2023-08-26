import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

final userDocument = FirebaseFirestore.instance.collection('users');

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key, required this.userUid}) : super(key: key);
  final String userUid;
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void addFriend() {}

  List<Contact> allContacts = [];
  List<Contact> displayedContacts = [];
  TextEditingController searchController =
      TextEditingController(); // Add this line

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    user();
    getContactPermission();
  }

  user() {
    userDocument.doc(widget.userUid).get().then((DocumentSnapshot doc) {
      var data = doc.data();
      print(data);
    });
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContacts();
    } else {
      await Permission.contacts.request();
    }
  }

  void fetchContacts() async {
    allContacts = await ContactsService.getContacts();

    setState(() {
      isLoading = false;
      displayedContacts = allContacts;
    });
  }

  void searchContacts(String query) {
    List<Contact> searchResults = [];

    if (query.isNotEmpty) {
      searchResults = allContacts.where((contact) {
        return contact.displayName
                ?.toLowerCase()
                .contains(query.toLowerCase()) ??
            false;
      }).toList();
    } else {
      searchResults = List.from(allContacts);
    }

    setState(() {
      allContacts;
      displayedContacts = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Contacts"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: searchContacts,
              decoration: InputDecoration(
                  labelText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)),
                  hoverColor: Colors.pinkAccent[100]),
            ),
          ),
          IconButton(
            onPressed: addFriend,
            icon: const Icon(Icons.add),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                  itemCount: displayedContacts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                color: Colors.white.withOpacity(0.1),
                                offset: const Offset(-3, -3),
                              ),
                              BoxShadow(
                                blurRadius: 7,
                                color: Color.fromARGB(255, 255, 139, 220)
                                    .withOpacity(0.7),
                                offset: const Offset(3, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.pinkAccent[100]),
                        child: Text(
                          displayedContacts[index].givenName![0],
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      title: Text(
                        displayedContacts[index].givenName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        displayedContacts[index].phones![0].value!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      horizontalTitleGap: 12,
                    );
                  },
                )),
        ],
      ),
    );
  }
}
