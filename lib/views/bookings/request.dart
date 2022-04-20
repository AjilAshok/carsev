

import 'package:carserv/views/bookings/track.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

Color clr = Colors.white;
final currenuserid=FirebaseAuth.instance.currentUser!.uid; 

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
//ongoinpage==================================

class Firstpage extends StatelessWidget {
  Firstpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      backgroundColor: Color(0xFF3D433E),
      body: onGoing(),
    );
  }
// ongoing body==============================
  StreamBuilder<QuerySnapshot<Object?>> onGoing() {
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance
                .collection('Userform').where("currenuserid",isEqualTo:currenuserid ).snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No Results'),
                  );
                }
        return ongoinglistview(snapshot);
      }
    );
  }
  // ongoinglistviwebuilder=============================

  ListView ongoinglistview(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(scrollDirection: Axis.vertical,
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          if (snapshot.data==null) {
            return Center(
              child: CircularProgressIndicator(),
            );
            
          }
          final shopdetails=snapshot.data!.docs[index];
        
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    shopdetails['ownername'],
                    style: TextStyle(color: clr, fontSize: 20),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                   
  
                  ),
                  // Text("Time Remaing :3.00",
                  //     style: TextStyle(color: clr, fontSize: 15))
                ]),
                 SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                 ),
  
                Text(shopdetails['shopname'], style: TextStyle(color: clr, fontSize: 20)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                 Text(shopdetails['location'], style: TextStyle(color: clr, fontSize: 20)),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                )
              ],
            ),
          );
        },
      );
  }
}
// Accepetedpage========================================

class Secondpage extends StatelessWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("************************");
    // print(currenuserid);
    return Scaffold(
      backgroundColor: Color(0xFF3D433E),
      body: Accepted(),
    );
  }
  // accepted body============================

  StreamBuilder<QuerySnapshot<Object?>> Accepted() {
    return StreamBuilder<QuerySnapshot>(
      stream:  FirebaseFirestore.instance.collection('Accepted').where('currentuserid',isEqualTo:currenuserid ).snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting) {
          // print(currenuserid);
          return Center(
            child: CircularProgressIndicator(),
          );
            
          
        }if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No one is accepted"),
          );
          
        }
        return accpetedlistview(snapshot);
      }
    );
  }
// acceptedlistviewbuilder=======================
  ListView accpetedlistview(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    // print(currenuserid);
    return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          final details=snapshot.data!.docs[index];
          print( details.id,);

        
          return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    details['works'],
                    style: TextStyle(color: clr, fontSize: 20),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
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
                         
                           Get.to(Trackmap(username: details['nameuser'],index: index,latitude: details['ownerlatitde'],longitude: details['ownerlongitude'],ownername: details['ownername'],shopname: details['shopname'] ,work:details['works'] ,complaint:details['complaint'] ,curretuserid:currenuserid,ownerid: details['ownerid'],docid: details.id,) );
                          },
                          child: Text(
                            "Track",
                            style: TextStyle(color: Colors.black),
                          )))
                ]),
                Text(details['shopname'], style: TextStyle(color: clr, fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.only(top:10 ),
                    child: Text(details['works'], style: TextStyle(color: clr, fontSize: 20)),
                  ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                )
              ],
            ),
          );
        },
      );
  }
}

// Experide==================================

class Thirdpage extends StatelessWidget {
  const Thirdpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(currenuserid);
    return Scaffold(
      backgroundColor: Color(0xFF3D433E),
      body: Experied(),
    );
  }
  // experiedbody========================

  StreamBuilder<QuerySnapshot<Object?>> Experied() {
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance
                .collection('Rejected').where("currentuserid",isEqualTo:currenuserid ).snapshots(), 
     
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No Results'),
                  );
                }
        return experiedlistview(snapshot);
      }
    );
  }
//listvieweexperied====================
  ListView experiedlistview(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          final shopdetails=snapshot.data!.docs[index];
        
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                   shopdetails['ownername'],
                    style: TextStyle(color: clr, fontSize: 20),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  experiedbutton()
                ]),
                Text(shopdetails['shopname'], style: TextStyle(color: clr, fontSize: 20)),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                )
              ],
            ),
          );
        },
      );
  }
  // Experiedbutton=================================

  Container experiedbutton() {
    return Container(
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
                        )));
  }
}
