import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneAuthOtp extends StatefulWidget {
  const PhoneAuthOtp({super.key});
  @override
  State<PhoneAuthOtp> createState() {
    return _PhoneAuthOtpState();
  }
}

class _PhoneAuthOtpState extends State<PhoneAuthOtp> {
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
    return Material(
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
                      text: "We just sent a code to ",
                      style: GoogleFonts.montserrat(
                        color: Color.fromARGB(255, 193, 95, 210),
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
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
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
                          setState(() {
                            screenState = 0;
                          });
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
            ],
          ),
        ),
      ),
    );
  }
}
