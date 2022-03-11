
import 'package:carserv/views/profile/contact.dart';
import 'package:carserv/views/profile/profiledetails.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFF3D433E),
      appBar: AppBar(
      
        toolbarHeight:60 ,
        centerTitle: true,
        elevation:0,
        backgroundColor: Color(0XFF738878),
        title:Text("Profile",style: GoogleFonts.montserrat(color: Colors.black,letterSpacing:2,fontSize:25) ,
        
      ),

    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap: (() {
              Navigator.push(context,MaterialPageRoute(builder: (context) => UserDetails(),));
            }),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.user,color: Colors.white,),
                SizedBox(width:30 ,),
                Text("Profile",style: GoogleFonts.montserrat(color: Colors.white,fontSize: 25),)
              ],
            ),
          ),
        ),
        Divider(
          thickness:1,
          color: Colors.white,
        ),
          Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap:(() =>  Navigator.push(context,MaterialPageRoute(builder: (context) =>ContactUs(),))),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.mobile,color: Colors.white,),
                SizedBox(width:30 ,),
                Text("Contact Us",style: GoogleFonts.montserrat(color: Colors.white,fontSize: 25),)
              ],
            ),
          ),
        ),
        Divider(
          thickness:1,
          color: Colors.white,
        ),
         Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(FontAwesomeIcons.info,color: Colors.white,),
              SizedBox(width:30 ,),
              Text("About ",style: GoogleFonts.montserrat(color: Colors.white,fontSize: 25),)
            ],
          ),
        ),
        Divider(
          thickness:1,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(Icons.note,color: Colors.white,),
              SizedBox(width:30 ,),
              Text("Bills/History",style: GoogleFonts.montserrat(color: Colors.white,fontSize: 25),)
            ],
          ),
        ),
        Divider(
          thickness:1,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(Icons.logout,color: Colors.white,),
              SizedBox(width:30 ,),
              Text("Logout",style: GoogleFonts.montserrat(color: Colors.white,fontSize: 25),)
            ],
          ),
        ),
        Divider(
          thickness:1,
          color: Colors.white,
        )


      ],
    ),
    )
    );
  }
}