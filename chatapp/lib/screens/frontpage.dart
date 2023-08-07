import 'package:flutter/material.dart';

import 'package:delayed_widget/delayed_widget.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Stack(
              children: [Container(
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
              child:  Center(
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
              ]
            ),
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
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70)),
                  ),
                ),
            ),
          ],
        ),
      
      ),
    );
  }
}
