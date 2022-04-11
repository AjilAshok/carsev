import 'package:carousel_slider/carousel_slider.dart';
import 'package:carserv/contoller/controler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Bikewash extends StatelessWidget {
  Bikewash({Key? key}) : super(key: key);
  final images = [
    "assets/ee559e05067b84b3f6b0c83b70b9fe1b.jpg",
    "assets/bike-washing-service-500x500.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CarouselSlider.builder(
            itemCount: images.length,
            options: CarouselOptions(
                autoPlayInterval: Duration(seconds: 10),
                height: 150,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1)),
            itemBuilder: (context, index, realindex) {
              final image = images[index];
              return buildimage(image, index);
            },
          ),
          Container(
            child: Text(
              "Need to Service your bike ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Owner')
                  .where("type", isEqualTo: 'Bike')
                  .where("chekbox", arrayContains: "Washing")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No owners'),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    // physics: NeverScrollableScrollPhysics(),

                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final ownerdetails = snapshot.data!.docs[index];
                      var location = ownerdetails['location'];

                      return InkWell(
                        onTap: () {
                          Get.to(Bikewashform(userid:ownerdetails.id ,shopname: ownerdetails['showname'],ownername: ['ownername'],location: ownerdetails['location'],));
                        },
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),

                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  height: 150,
                                  width: MediaQuery.of(context).size.width / 2,
                                  color: Colors.green,
                                  child: Image(
                                    image: AssetImage(
                                        "assets/istockphoto-1179753682-612x612.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  child: Text(
                                    """Company  service Time Duration 1 Hourpick from your home and service 
                                          
$location""",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                            //  Divider(
                            //   thickness: 1,
                            //   color: Colors.black,
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              ownerdetails['showname'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Amount  ",
                                    style: TextStyle(fontSize: 15)),
                                Text("₹340",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              })
        ],
      ),
    ));
  }

  Widget buildimage(String image, int index) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      // color: Colors.red,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill)),
    );
  }
}

class Bikewashform extends StatelessWidget {
  Bikewashform({Key? key, required this.userid,
      required this.ownername,
      required this.shopname,
      required this.location}) : super(key: key);
   var userid;
  var ownername;
  var shopname;
  var location;
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController work = TextEditingController();
  var names = '';
  final currentuserid = FirebaseAuth.instance.currentUser!.uid;


  @override
  Widget build(BuildContext context) {
    work.text = "Bikewash";
     name.text = names;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF738878),
          title: Text(
            "Bikewash",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.maxFinite,
                  color: Color(0XFF738878),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "| Don’t worry we are help you.",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Row(
                          children: [
                            Text("Registeration form",
                                style: GoogleFonts.rokkitt(
                                    color: Color(0XFF72E77E), fontSize: 25)),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              height: 140,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/bike-washing-service-500x500.jpg"),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter some text";
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    controller: work,
                    decoration: InputDecoration(
                      hintText: "Bikewash",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Color(0xFF008000), width: 1)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Color(0xFF008000)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter some text";
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    controller: name,
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Color(0xFF008000), width: 1)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Color(0xFF008000)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 50, right: 50),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter some text";
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    controller: message,
                    decoration: InputDecoration(
                      hintText: "Messsage",
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Color(0xFF008000)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: Color(0xFF008000), width: 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF62A769)),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.black, fontSize: 20, letterSpacing: 1),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  bikewashform()async{
      final controler = Get.put(Servicecontroller());
    bool expire = false;

    var user = FirebaseAuth.instance.currentUser;
    var collection = FirebaseFirestore.instance.collection('Users');
    var docSnapshot = await collection.doc(user!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      names = data?['Name'];
      // <-- The value you want to retrieve.
      //  print(value);
      print(names);
    }
    CollectionReference userwashform =
        FirebaseFirestore.instance.collection("Userform");
    return userwashform.add({
      "work": work.text,
      "Manufacture": "NIL",
      "model": "NIL",
      'year': "NIL",
      "issues": message.text,
      "owerid": userid,
      "location": location,
      "shopname": shopname,
      "ownername": ownername,
      "userlocation": controler.address.value,
      "username": names,
      "experied": expire,
      "currenuserid": currentuserid,
      "latitude":controler.latitude.value,
      "logitude":controler.longitude.value
    }).then((value) => print("carwashform"));
  }
    
  }

