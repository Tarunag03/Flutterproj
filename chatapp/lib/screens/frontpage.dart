import 'package:chatapp/screens/firstpage.dart';
import 'package:chatapp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_widget/delayed_widget.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    Route _createRoute() {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Login(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;

          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      );
    }

    double leftCornerRadius = MediaQuery.of(context).size.width * 0.34;
    print(leftCornerRadius);
    return Material(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 0.79,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent[100],
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(70)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 0.8,
                child: Center(
                  child: DelayedWidget(
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    delayDuration: const Duration(milliseconds: 800),
                    animationDuration: const Duration(milliseconds: 1300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset('assets/images/chat.gif'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent[100],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Welcome to Namaste",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      wordSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 7.2,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8.92,
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: DefaultTextStyle(
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TyperAnimatedText(
                            "Welcome to Indian brand chat app where you can be in touch with your loved one's very easily",
                            speed: const Duration(milliseconds: 31),
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 7.2,
                  ),
                  Material(
                    color: Colors.pinkAccent[100],
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => firstpage(userUid:FirebaseAuth.instance.currentUser!.uid,)));
                        } else {
                          FadeTransition;

                          Navigator.pop(context);
                          Navigator.of(context).push(_createRoute());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>Login()));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextLiquidFill(
                          waveDuration: Duration(milliseconds: 500),
                          loadDuration: Duration(milliseconds: 4000),
                          textAlign: TextAlign.center,
                          boxBackgroundColor:
                              const Color.fromARGB(255, 254, 124, 168),
                          text: 'Get Started',
                          waveColor: Colors.white,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                          boxWidth: MediaQuery.of(context).size.width / 1.4,
                          boxHeight: MediaQuery.of(context).size.height / 16,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
