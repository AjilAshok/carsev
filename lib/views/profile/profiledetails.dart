import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 0,
          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
          Navigator.pop(context);
        },),
       
        backgroundColor: Color(0XFF738878),
        title: Text("Edit profile",style: GoogleFonts.montserrat(color: Colors.black),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10,left:10 ),
              height:40 ,
              width: double.maxFinite,
              color: Colors.grey,
              child:Text("Profile Info",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),) ,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.user,color: Colors.black,),
                  SizedBox(
                    width: 10,
                  ),
                  
                 Expanded(
                   child: TextField(
                     decoration: InputDecoration(hintText: "Name"),
                               
                   ),
                 )
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.mobile,color: Colors.black,),
                  SizedBox(
                    width: 10,
                  ),
                  
                 Expanded(
                   child: TextField(
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(hintText: "Mobile number"),
                               
                   ),
                 )
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.mailBulk,color: Colors.black,),
                  SizedBox(
                    width: 10,
                  ),
                  
                 Expanded(
                   child: TextField(
                     keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(hintText: "Email"),
                               
                   ),
                 )
                ],
              ),
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height*0.48,
            ),
            Container(
              height:40 ,
        
              width: double.maxFinite,
              
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color(0XFF738878))),
                
                onPressed: (){
      
              }, child: Text("Update Profile",style: TextStyle(color: Colors.black),)),
            )
          ],
        ),
      ),

    ));
      
    
  }
}