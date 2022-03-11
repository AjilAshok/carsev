

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:carserv/contoller/controler.dart';
import 'package:carserv/views/bootomnav/home.dart';

import 'package:carserv/views/login.dart';
import 'package:carserv/views/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(Servicecontroller());

    return AnimatedSplashScreen(
      backgroundColor: Color(0XFF3D433E),
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: [
          Container(
            height: 150,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(500)),
                image: DecorationImage(
                    image: AssetImage(
                        "assets/1b3f3e2ac8d54e252aaf4bf798e9dbfa--motorcycle-mechanic-motorcycle-logo.jpg"))),
          ),
          SizedBox(
            height: 100,
          ),
          Text("CarServ",
              style: GoogleFonts.rye(fontSize: 30, color: Colors.white))
        ],
      ),
      nextScreen: 
      // Homescreen(),
      Loginpage(),
      duration: 3000,
      splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      animationDuration: Duration(seconds: 1),
      splashIconSize: 350,
    );
  }
}
