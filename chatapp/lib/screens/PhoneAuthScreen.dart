import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey();

    FocusNode focusNode = FocusNode();
    return Material(
      child: Center(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
            child: Column(
              children: [
                const Text(
                  'Phone Number ',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 193, 95, 210)),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Enter the Phone Number to the app and otp",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
                const SizedBox(
                  height: 70,
                ),
                Expanded(
                  child: Form(
                    child: Column(
                      children: [
                        IntlPhoneField(
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          languageCode: "en",
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            print('Country changed to: ' + country.name);
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 50, //height of button
                          width: 300,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Processing Login wait')));
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
    );
  }
}
