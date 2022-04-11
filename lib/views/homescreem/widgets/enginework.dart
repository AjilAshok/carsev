
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carserv/contoller/controler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:native_notify/native_notify.dart';

class Enginework extends StatelessWidget {
  Enginework({Key? key}) : super(key: key);
  final images = ["assets/slider-bg.jpg", "assets/details-dec-2.jpg"];

  @override
  Widget build(BuildContext context) {
    print('start0');
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
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
            Text(
              "We ready to service your vehicle",
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Owner')
                    .where("type", isEqualTo: 'Car')
                    .where("chekbox", arrayContains: "Enginework")
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
                        // print(ownerdetails.id);

                        return InkWell(
                          onTap: () {
                            Get.to(Engineform(
                              userid: ownerdetails.id,
                              shopname: ownerdetails['showname'],
                              ownername: ownerdetails['ownername'],
                              location: ownerdetails['location'],
                            ));
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    color: Colors.green,
                                    child: Image(
                                      image: AssetImage("assets/services.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    child: Text(
                                      """Company  service Time Duration 30 Hourpick from your home and service
                                    $location""",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
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
                                  Text("Minimum Amount  ",
                                      style: TextStyle(fontSize: 15)),
                                  Text("₹200",
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
      ),
    );
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

class Engineform extends StatelessWidget {
  Engineform(
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

  TextEditingController enginecontrole = TextEditingController();
  TextEditingController issucontroler = TextEditingController();
  final engineitesm = [
    "item 1",
    "item 2",
    "item 3",
    "item 4",
    "item 5",
    "item 6",
    "item 7",
    "item 8"
  ];
  final eginemodel = [
    "model 1",
    "model 2",
    "model 3",
    "model 4",
    "model 5",
    "model 6",
    "model 7",
    "model 8"
  ];
  final engineyears = [
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021"
  ];
  final _formKey = GlobalKey<FormState>();
  final engineformcontroler = Get.put(Servicecontroller());
  var name = '';
   

  @override
  Widget build(BuildContext context) {
     
     
    enginecontrole.text = 'Engineworks';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF738878),
          title: Text(
            "Enginework",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
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
                        // SizedBox(
                        //   height: 70,
                        // ),
                        Row(
                          children: [
                            Text("Enginework form",
                                style: GoogleFonts.rokkitt(
                                    color: Color(0XFF72E77E), fontSize: 25)),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              height: 140,
                              width: 150,
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
                  padding: const EdgeInsets.only(
                      top: 50, left: 50, right: 50, bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                    controller: enginecontrole,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enginework",
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
                GetBuilder<Servicecontroller>(
                  builder: (controller) => Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 50, right: 50, bottom: 10),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.black,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            border: Border.all(color: Color(0xFF008000))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Manufacture",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              isExpanded: true,
                              iconEnabledColor: Color(0xFF008000),
                              value: controller.valueengine,
                              items: engineitesm.map(buildmenu).toList(),
                              onChanged: (value) {
                                controller.Enginedromdown(value);
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
                GetBuilder<Servicecontroller>(
                  builder: (controller) => Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 50, right: 50, bottom: 10),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.black,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            border: Border.all(color: Color(0xFF008000))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Model",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              isExpanded: true,
                              iconEnabledColor: Color(0xFF008000),
                              value: controller.valuemodel,
                              items: eginemodel.map(buildmenu).toList(),
                              onChanged: (value) {
                                controller.engienmodel(value);
                                if (controller.valuemodel == null) {}
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
                GetBuilder<Servicecontroller>(
                  builder: (controller) => Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 50, right: 50, bottom: 10),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.black,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            border: Border.all(color: Color(0xFF008000))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Year",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            isExpanded: true,
                            iconEnabledColor: Color(0xFF008000),
                            value: controller.valueengine1,
                            // items: years.map(buildmenu).toList(),
                            onChanged: (value) {
                              controller.Enginedromdown1(value);
                            },
                            items: engineyears.map((String value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 250, 250, 250))),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, left: 50, right: 50, bottom: 10),
                  child: TextFormField(
                    controller: issucontroler,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Issue message",
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
                Padding(
                  padding: EdgeInsets.all(8),
                  child: GetBuilder<Servicecontroller>(
                      builder: (controller) => Text(
                            controller.valid.toString(),
                            style: TextStyle(color: controller.color),
                          )),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 180,
                  height: 50,
                  child: GetBuilder<Servicecontroller>(
                    builder: (controller) => ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF62A769)),
                      ),
                      onPressed: () async {
                        //  final controller = Get.find<Servicecontroller>();
                        if (controller.valueengine1 != null) {
                          // print(controller.valueengine1);
                          controller.formvalide("Select a option", Colors.red);
                        }
                        if (controller.valuemodel != null) {
                          // print(controller.valuemodel);
                          controller.formvalide("Select a option", Colors.red);
                        }
                        if (controller.valueengine != null) {
                          // print(controller.valueengine);
                          controller.formvalide("Select a option", Colors.red);
                        }
                        // print(controller.valueengine);
                        if (_formKey.currentState!.validate()) {
                          await engineworkform();
                          yourIndiePushSendingFunction(); 
                        // print('object');
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            letterSpacing: 1),
                      ),
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

  DropdownMenuItem<String> buildmenu(String item) => DropdownMenuItem(
      value: item,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item,
          style: const TextStyle(color: Color.fromARGB(255, 250, 250, 250)),
        ),
      ));

  engineworkform() async {
     
    bool expire = false;
    print('alsdjlfd');

    
    var user = FirebaseAuth.instance.currentUser;
    var collection = FirebaseFirestore.instance.collection('Users');
    var docSnapshot = await collection.doc(user!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      name = data?['Name'];
      // <-- The value you want to retrieve.
      //  print(value);

    }

    final controller = Get.find<Servicecontroller>();
   
    final currentuserid = FirebaseAuth.instance.currentUser!.uid;
    print(currentuserid);
    // print(userid);
    print(controller.latitude.value);
  

    CollectionReference userform =
        FirebaseFirestore.instance.collection("Userform");

    return userform.add({
      "work": enginecontrole.text,
      "Manufacture": engineformcontroler.valueengine.toString(),
      "model": engineformcontroler.valuemodel.toString(),
      "year": engineformcontroler.valueengine1.toString(),
      "issues": issucontroler.text,
      "owerid": userid,
      "location": location,
      "shopname": shopname,
      "ownername": ownername,
      "userlocation": controller.address.value,
      "username": name,
      "currenuserid": currentuserid,
      "experied": expire,
      "latitude":controller.latitude.value,
      "logitude":controller.longitude.value,
      "date":DateFormat('dd-MM-yyyy').format(DateTime.now())
    }).then((value) => print("usweengineform"));
    // .onError((error, stackTrace) => print(error));
  }
 void yourIndiePushSendingFunction() {
    
    NativeNotify.sendIndieNotification(472, 'qMMR6PMv5Lfht6dCRrmQzA', '4', 'You have new request', '$name', null, null);
    // yourAppID, yourAppToken, 'your_sub_id', 'your_title', 'your_body' is required
    // put null in any other parameter you do NOT want to use
}
}
