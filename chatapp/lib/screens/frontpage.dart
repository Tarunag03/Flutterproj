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
              delayDuration:const  Duration(milliseconds: 800),
              animationDuration:const Duration(milliseconds: 1300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
    
                  child: Image.asset(
                'assets/images/chat.gif'
                  ),
                  ),
                    ]
    )
      )
    )
    );
  }
}
