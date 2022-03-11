import 'package:carserv/contoller/controler.dart';
import 'package:carserv/views/bookings/request.dart';

import 'package:carserv/views/homescreem/homescreen.dart';
import 'package:carserv/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Homescreen extends StatelessWidget {
  Homescreen({Key? key}) : super(key: key);
  final pages = [Mainhomescreen(), RequestPage(), Profilepage()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 249, 249),
      body: GetBuilder<Servicecontroller>(
          builder: (controller) => pages[controller.currenindex]),
      bottomNavigationBar: GetBuilder<Servicecontroller>(
        builder: (controller) => BottomNavigationBar(

            //  backgroundColor: Colors.black,
            currentIndex: controller.currenindex,
            unselectedFontSize: 10,
            selectedFontSize: 15,
            unselectedItemColor: Color.fromARGB(255, 31, 30, 30),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            elevation: 0,
            onTap: (index) {
              controller.bottomnavbar(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Bookings",
                icon: Icon(FontAwesomeIcons.screwdriver),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(FontAwesomeIcons.userAlt ),
              )
            ]),
      ),
    ));
  }
}
