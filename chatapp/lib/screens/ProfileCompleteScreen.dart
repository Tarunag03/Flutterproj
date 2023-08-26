import 'package:chatapp/services/navigate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatapp/services/utils.dart';
import 'package:chatapp/screens/firstpage.dart'; // Import firstpage

class ProfileCompleteScreen extends StatelessWidget {
  ProfileCompleteScreen({Key? key}) : super(key: key);

  Future<void> inputData(User user) async {
    Map<String, dynamic> userData = {
      "username": usernameController.text.trim(),
      "email": emailController.text.trim(),
      "uid": user.uid,
      "profilecomplete": true,
      "friends": [],
    };

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set(userData); // Use set instead of add
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final userNameValidator = MultiValidator([
    MinLengthValidator(8, errorText: 'Name must be at least 8 characters long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Name must have at least one special character')
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Complete Profile",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 225, 169, 187),
          Color.fromRGBO(216, 183, 222, 1)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 120, 16, 16),
            child: Column(children: [
              Text(
                "Enter the Username and Email",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    controller: usernameController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(25),
                    ],
                    decoration: const InputDecoration(
                        label: Text('UserName'),
                        icon: FaIcon(FontAwesomeIcons.person)),
                    validator: userNameValidator,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(25),
                    ],
                    decoration: const InputDecoration(
                        label: Text('Email'),
                        icon: FaIcon(FontAwesomeIcons.user)),
                    validator: MultiValidator([
                      EmailValidator(errorText: 'Enter a valid email address'),
                      RequiredValidator(errorText: 'Enter Email address')
                    ]),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 50, // Height of button
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await inputData(auth.currentUser!);
                          checkProfileAndNavigate(auth.currentUser!, context);
                        }
                      },
                      child: const Text(
                        'Continue to app',
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
