import 'package:flutter/material.dart';

import 'package:delayed_widget/delayed_widget.dart';


class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
          child: DelayedWidget(
              animation: DelayedAnimations.SLIDE_FROM_BOTTOM, 
              delayDuration:const  Duration(milliseconds: 500),// Not required
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                  ),
                   Container(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                  ),
                   const SizedBox(height: 5),
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                  ),
                ],
              ))),
    );
  }
}
