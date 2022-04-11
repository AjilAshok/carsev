import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetails extends StatelessWidget {
  UserDetails({Key? key}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    var firebaseuser = FirebaseAuth.instance.currentUser;
    var collection = FirebaseFirestore.instance.collection('Users');

   

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Color(0XFF738878),
              title: Text(
                "Edit profile",
                style: GoogleFonts.montserrat(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  height: 40,
                  width: double.maxFinite,
                  color: Colors.grey,
                  child: Text(
                    "Profile Info",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.user,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                      
                        child: StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                            stream: collection
                                .doc(firebaseuser!.uid)
                                .snapshots(),
                            builder: (context, Snapshot) {
                              if (Snapshot.hasError) {
                                return Text("eror");
                              
                                
                              }
                              if (Snapshot.connectionState==ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                                
                              }
                              var output = Snapshot.data!.data();
                              if (output==null) {
                                return CircularProgressIndicator();
                                
                              }
                              var value = output["Name"];

                              return 
                               TextField(
                                  controller:
                                      TextEditingController(text: value),
                                  decoration:
                                      InputDecoration(hintText: "Name"));
                            }),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.mobile,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: null,
                          builder: (context, snapshot) {
                            return Expanded(
                              child: TextField(
                                controller: TextEditingController(text:firebaseuser.phoneNumber ),
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(hintText: "Mobile number"),
                              ),
                            );
                          })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.mailBulk,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: collection
                                .doc(firebaseuser.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.data==null) {
                                return CircularProgressIndicator();
                              }
                              var output = snapshot.data!.data();
                               if (output==null) {
                                return CircularProgressIndicator();
                                
                              }
                              var value = output["email"];
                              return TextField(
                                controller: TextEditingController(text: value),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(hintText: "Email"),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.48,
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0XFF738878))),
                      onPressed: () {},
                      child: Text(
                        "Update Profile",
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ],
            ))));
    // }
    // ),
  }
}
