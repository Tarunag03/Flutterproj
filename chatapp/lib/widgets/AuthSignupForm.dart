import 'dart:developer';

import 'package:chatapp/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AuthSignUpForm extends StatefulWidget {
  const AuthSignUpForm({super.key});
  @override
  State<AuthSignUpForm> createState() {
    return _AuthSignUPFormState();
  }
}

class _AuthSignUPFormState extends State<AuthSignUpForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String username = usernameController.text.trim();
    //   String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "") {
      log("Please fill all the details!");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Map<String, dynamic> userData = {
            "username": username,
            " email": email,
          };
          FirebaseFirestore.instance.collection("users").add(userData);
          Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  var _isObsecured = true;
  void _toggle() {
    setState(() {
      _isObsecured = !_isObsecured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userNameValidator = MultiValidator([
      MinLengthValidator(8, errorText: 'name must be at least 6 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'name must have at least one special character')
    ]);
    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(8,
          errorText: 'password must be at least 8 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'passwords must have at least one special character')
    ]);
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          controller: usernameController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(25),
          ],
          decoration: const InputDecoration(
              label: Text('UserName'), icon: FaIcon(FontAwesomeIcons.person)),
          validator: userNameValidator,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: emailController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(25),
          ],
          decoration: const InputDecoration(
              label: Text('Email'), icon: FaIcon(FontAwesomeIcons.user)),
          validator: MultiValidator([
            EmailValidator(errorText: 'enter a valid email address'),
            RequiredValidator(errorText: 'Enter Email address')
          ]),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: passwordController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(25),
          ],
          obscureText: _isObsecured,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                padding: const EdgeInsetsDirectional.only(end: 12.0),
                onPressed: _toggle,
                icon: _isObsecured
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              label: const Text('Password'),
              icon: const FaIcon(FontAwesomeIcons.lock)),
          validator: passwordValidator,
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 50, //height of button
          width: 300,
          child: ElevatedButton(
              onPressed: () {
                createAccount();
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Login wait')));
                }
              },
              child: const Text(
                'SignUp',
                style: TextStyle(fontSize: 23),
              )),
        ),
      ]),
    );
  }
}
