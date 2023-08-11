import 'package:chatapp/widgets/PhoneAuthOtp.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController phoneController = TextEditingController();
  var phoneNumber = "";

  void func(phone) {
    String phonenumber = phone;
  }

  void sendOTP() async {
    print(phoneNumber);
    String phone = phoneNumber.trim();
    print(phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhoneAuthOtp(
                      verificationId: verificationId,
                      phone: phoneNumber,
                      sendOTP: sendOTP)));
        },
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          //  log(ex.code.toString());
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: const Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey();

    FocusNode focusNode = FocusNode();
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Phone Number",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 250, 142, 178),
          Color.fromRGBO(218, 75, 243, 1)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
              child: Column(
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/images/otp.gif',
                    ),
                  ),
                  const Text(
                    "Enter the Phone Number to continue to the app and otp",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          IntlPhoneField(
                            controller: phoneController,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            languageCode: "en",
                            onChanged: (phone) {
                              phoneNumber = phone.completeNumber.toString();
                              print(phoneNumber);
                              func(phoneNumber.toString());
                            },
                            onCountryChanged: (country) {
                              print('Country changed to: ' + country.name);
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            height: 50, //height of button
                            width: 300,
                            child: ElevatedButton(
                                onPressed: () {
                                  sendOTP();
                                  if (_formKey.currentState!.validate()) {
                                    //sir yha kya dalega wo daal do
                                  } else {
                                    print('hello');
                                  }
                                },
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text(
                                        'Continue',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 70),
                                      child: FaIcon(
                                          FontAwesomeIcons.arrowRightToBracket),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
