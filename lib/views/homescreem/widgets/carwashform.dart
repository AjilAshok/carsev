import 'package:carserv/contoller/controler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:native_notify/native_notify.dart';

class Carwashform extends StatelessWidget {
  Carwashform(
      {Key? key,
      required this.userid,
      required this.ownername,
      required this.shopname,
      required this.location})
      : super(key: key);
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
    print(ownername);
    work.text = "Carwash";
    name.text = names;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF738878),
          title: Text(
            "Carwash",
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
                                          "assets/service-details.jpg"),
                                      fit: BoxFit.fill)),
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
                      hintText: "Carwash",
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
                    onPressed: () async {
                      print('press');
                      if (_formKey.currentState!.validate()) {
                        yourIndiePushSendingFunction();
                        carwashform();
                      }
                    },
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

  carwashform() async {
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
      "logitude":controler.longitude.value,
      "date":DateFormat('dd-MM-yyyy').format(DateTime.now())
    }).then((value) => print("carwashform"));
  }
  void yourIndiePushSendingFunction() {
    
    NativeNotify.sendIndieNotification(472, 'qMMR6PMv5Lfht6dCRrmQzA', '4', 'You have new request', '$name', null, null);
    // yourAppID, yourAppToken, 'your_sub_id', 'your_title', 'your_body' is required
    // put null in any other parameter you do NOT want to use
}
}
