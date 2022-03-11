

import 'package:carserv/views/bookings/track.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

Color clr = Colors.white;

class RequestPage extends StatelessWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Text(
              "Ongoing",
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
            ),
            Text(
              "Accepted",
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
            ),
            Text(
              "Expired",
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
            ),
          ]),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0XFF738878),
          title: Text(
            "Bookings",
            style: TextStyle(color: Colors.black, letterSpacing: 1),
          ),
        ),
        body: TabBarView(children: [Firstpage(), Secondpage(), Thirdpage()]),
      ),
    ));
  }
}

class Firstpage extends StatelessWidget {
  Firstpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3D433E),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    "Owner Name",
                    style: TextStyle(color: clr, fontSize: 20),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Text("Time Remaing :3.00",
                      style: TextStyle(color: clr, fontSize: 15))
                ]),
                Text("Shop Name", style: TextStyle(color: clr, fontSize: 20)),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class Secondpage extends StatelessWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3D433E),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    "Owner Name",
                    style: TextStyle(color: clr, fontSize: 20),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 45,
                      width: 100,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                // side: BorderSide(color: Color.fromARGB(255, 3, 3, 3))
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0XFF62A769))),
                          onPressed: () {
                            Get.to(Trackmap());
                          },
                          child: Text(
                            "Track",
                            style: TextStyle(color: Colors.black),
                          )))
                ]),
                Text("Shop Name", style: TextStyle(color: clr, fontSize: 20)),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class Thirdpage extends StatelessWidget {
  const Thirdpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3D433E),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    "Owner Name",
                    style: TextStyle(color: clr, fontSize: 20),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 45,
                      width: 100,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                // side: BorderSide(color: Color.fromARGB(255, 3, 3, 3))
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0XFF62A769))),
                          onPressed: () {},
                          child: Text(
                            "Expired",
                            style: TextStyle(color: Colors.black),
                          )))
                ]),
                Text("Shop Name", style: TextStyle(color: clr, fontSize: 20)),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
