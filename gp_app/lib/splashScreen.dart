import 'package:flutter/material.dart';
import 'package:gp_app/signIn.dart';
import 'package:gp_app/signUp.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/tooth logo.png'),
          SizedBox(height: 15,),
          Text("ALCA",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'SegoeUI',fontSize: 50,color: Colors.white),)
        ],
      ),
      nextScreen: (signIn()),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Color(0xff31c4cd),
      splashIconSize: 700,
    );
  }
}