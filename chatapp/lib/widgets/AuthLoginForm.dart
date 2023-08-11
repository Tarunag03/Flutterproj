import 'dart:developer';

import 'package:chatapp/screens/firstpage.dart';
import 'package:chatapp/screens/resetpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AuthLoginForm extends StatefulWidget {
  const AuthLoginForm({super.key});
  @override
  State<AuthLoginForm> createState() {
    return _AuthLoginFormState();
  }
}

class _AuthLoginFormState extends State<AuthLoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      log("Please fill all the fields!");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => firstpage()));
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
          height: 12,
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
                login();
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Login wait')));
                }
              },
              child: const Text(
                'LogIn',
                style: TextStyle(fontSize: 23),
              )),
            

        ),
         Center(
           child: Container(
               width: MediaQuery.of(context).size.width/1.0,
               height:60,
               alignment: Alignment.bottomRight,
               child: TextButton(
                 child: const Text(
            "Forgot Password?",
            style: TextStyle(color: const Color.fromARGB(255, 236, 40, 190)),
            textAlign: TextAlign.right,
                 ),
                 onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) =>ResetPassword())),
               ),
             ),
         ),
      ]),
    );
  }
}
