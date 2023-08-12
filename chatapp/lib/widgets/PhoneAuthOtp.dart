import 'dart:async';
import 'dart:developer';

import 'package:chatapp/screens/PhoneAuthScreen.dart';
import 'package:chatapp/screens/ProfileCompleteScreen.dart';
import 'package:chatapp/screens/firstpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneAuthOtp extends StatefulWidget {
  final String verificationId;
  final String phone;
  final void Function() sendOTP;
  const PhoneAuthOtp(
      {super.key,
      required this.verificationId,
      required this.phone,
      required this.sendOTP});
  @override
  State<PhoneAuthOtp> createState() {
    return _PhoneAuthOtpState();
  }
}

class _PhoneAuthOtpState extends State<PhoneAuthOtp> {
  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ProfileCompleteScreen()));
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";
  StreamController<ErrorAnimationType>? errorController;
  double screenHeight = 0;
  double screenWidth = 0;
  double bottom = 0;
  String currentText = "";
  int screenState = 0;

  Color blue = const Color(0xff8cccff);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 250, 142, 178),
            Color.fromRGBO(218, 75, 243, 1)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "We just sent a code to ${widget.phone} ",
                          style: GoogleFonts.montserrat(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: phoneController.text,
                          style: GoogleFonts.montserrat(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: "\nEnter the code here and we can continue!",
                          style: GoogleFonts.montserrat(
                            color: Colors.black87,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth / 12),
                    child: Expanded(
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          color: Color.fromARGB(255, 193, 95, 210),
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: '*',
                        obscuringWidget: const Icon(Icons.star),
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 60,
                            fieldWidth: 50,
                            activeFillColor: Colors.white,
                            activeColor: Colors.white),
                        animationCurve: Curves.easeInBack,
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          verifyOTP();
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                            print(value);
                          });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");

                          return true;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn't receive the code? ",
                          style: GoogleFonts.montserrat(
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              widget.sendOTP();
                            },
                            child: Text(
                              "Resend",
                              style: GoogleFonts.montserrat(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Need to Change Number ${widget.phone} ?  ",
                          style: GoogleFonts.montserrat(
                            color: Colors.black87,
                            fontSize: 13,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PhoneAuthScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Click here",
                              style: GoogleFonts.montserrat(
                                color: Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
