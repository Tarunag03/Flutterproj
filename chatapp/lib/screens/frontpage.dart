import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_widget/delayed_widget.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});
  
  @override
  Widget build(BuildContext context) {
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
<<<<<<< HEAD
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(leftCornerRadius),
                  ),
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
=======
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
>>>>>>> 8604d5eb4751e7da2560bf5d4ccae959d4cd2341
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
<<<<<<< HEAD
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black.withOpacity(0.6),
                      ),
=======
                    height: MediaQuery.of(context).size.height / 8.92,
                    width: MediaQuery.of(context).size.width / 2.4,
                    child: DefaultTextStyle(
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
>>>>>>> 8604d5eb4751e7da2560bf5d4ccae959d4cd2341
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TyperAnimatedText(
<<<<<<< HEAD
                              "Welcome to Indian brand chat app where you can be in touch with your loved one's very easily"),
=======
                            "Welcome to Indian brand chat app where you can be in touch with your loved one's very easily",
                            speed: const Duration(milliseconds: 31),
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
>>>>>>> 8604d5eb4751e7da2560bf5d4ccae959d4cd2341
                        ],
                      ),
                    ),
                  ),
<<<<<<< HEAD
=======
                   SizedBox(
                    height: MediaQuery.of(context).size.width / 7.2,
                  ),
                  Material(
                    
                    color: Colors.pinkAccent[100],
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                borderRadius: BorderRadius.circular(20),
                     
                      onTap: (){},
                      child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextLiquidFill(
                        waveDuration: Duration(seconds: 2),
                       loadDuration: Duration(milliseconds: 900),
                        textAlign: TextAlign.center,
                         
                        boxBackgroundColor: const Color.fromARGB(255, 254, 124, 168),
                       text: 'Get Started',
                       waveColor: Colors.white,

                        textStyle: const TextStyle(
                        color: Colors.white,
                        
                         fontSize: 26,
                         letterSpacing: 1,
                               fontWeight: FontWeight.bold,
                      ),
                          boxWidth:MediaQuery.of(context).size.width / 1.7,
                          boxHeight: MediaQuery.of(context).size.height / 16,
                             ),
                    ),
                      
                    ),
                  )
>>>>>>> 8604d5eb4751e7da2560bf5d4ccae959d4cd2341
                ]),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
