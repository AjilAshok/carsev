import 'package:carousel_slider/carousel_slider.dart';
import 'package:carserv/contoller/controler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:native_notify/native_notify.dart';

class Breakdownbike extends StatelessWidget {
  Breakdownbike({Key? key}) : super(key: key);
  final images = [
    "assets/Motorcycle-Breakdown.jpg",
    "assets/d8411be98a7cba0a897438d97ad7ba8e.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final controler=Get.put(Servicecontroller());
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
              "Your Vehicle breakdown don't worry we help you",
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
                    .where("type", isEqualTo: 'Bike')
                    .where("chekbox", arrayContains: "Brekdown")
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
                   List<Map> ownerDetails = [];
                  List distance = [];

                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                   
                    final doubledistacne = Geolocator.distanceBetween(
                      controler.latitude.value,
                      controler.longitude.value,
                      snapshot.data!.docs[i]['latitude'],
                      snapshot.data!.docs[i]['longitude'],
                    );

                    ownerDetails.add({
                      'distance': doubledistacne.round().toInt() / 1000,
                      'shopName': snapshot.data!.docs[i]['showname'],
                      'ownerName': snapshot.data!.docs[i]['ownername'],
                      'location': snapshot.data!.docs[i]['location'],
                      'ownerId': snapshot.data!.docs[i].id,
                    });
                  }

                  List sortedOwnerList = [
                    for (var e in ownerDetails)
                      if (e["distance"] < 15) e
                  ];

                  print(sortedOwnerList);
                  if (sortedOwnerList.isEmpty) {
                    return Center(
                      child: Text("No Owner"),
                    );
                    
                  }
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      // physics: NeverScrollableScrollPhysics(),

                      itemCount: sortedOwnerList.length,
                      itemBuilder: (context, index) {
                        final ownerdetails = snapshot.data!.docs[index];
                        var location = ownerdetails['location'];
                         final sortedOwnerMap = sortedOwnerList[index];

                        return InkWell(
                          onTap: () {
                            Get.to(Bikebreakdownform(
                              userid: sortedOwnerMap['ownerId'],
                                shopname: sortedOwnerMap['shopName'],
                                ownername: sortedOwnerMap['ownerName'],
                                location: sortedOwnerMap['location'],
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
                                      image: AssetImage(
                                          "assets/d8411be98a7cba0a897438d97ad7ba8e.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    child: Text(
                                      """Company  service Time Duration 30 Hourpick from your home and service
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
                              Row(
                                children: [
                                  Text(
                                    sortedOwnerMap['shopName'],
                                    style: TextStyle(
                                        fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                   Text(
                                    '${sortedOwnerMap['distance'].round()} KM',
                                    style:const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Minimum Amount  ",
                                      style: TextStyle(fontSize: 15)),
                                  Text("???100",
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

class Bikebreakdownform extends StatelessWidget {
  Bikebreakdownform(
      {Key? key,
      required this.userid,
      required this.location,
      required this.shopname,
      required this.ownername})
      : super(key: key);
  final bikesites = [
    "item 1",
    "item 2",
    "item 3",
    "item 4",
    "item 5",
    "item 6",
    "item 7",
    "item 8"
  ];

  final bikemodel = [
    "model 1",
    "model 2",
    "model 3",
    "model 4",
    "model 5",
    "model 6",
    "model 7",
    "model 8"
  ];
  final bikesyears = [
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
  TextEditingController work = TextEditingController();
  TextEditingController issues = TextEditingController();
  var names;
  var userid;
  var ownername;
  var shopname;
  var location;

  @override
  Widget build(BuildContext context) {
    work.text = "Breakdown";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          elevation: 0,
          backgroundColor: Color(0XFF738878),
          title: Text(
            "Breakdown",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                          "| Don???t worry we are help you.",
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
                            Text("Complaint form",
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
                                          "assets/Motorcycle-Breakdown.jpg"),
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
                    controller: work,
                    validator: (values) {
                      if (values == null || values.isEmpty) {
                        return "Enter the text";
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Work",
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
                          child: DropdownButtonFormField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Manufacture",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              validator: (values) {
                                if (values == null) {
                                  return "Select a field";
                                }
                              },
                              isExpanded: true,
                              iconEnabledColor: Color(0xFF008000),
                              value: controller.bikebrekdown,
                              items: bikesites.map(buildmenu).toList(),
                              onChanged: (value) {
                                controller.bikebreakdown(value);
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
                          child: DropdownButtonFormField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              validator: (values) {
                                if (values == null) {
                                  return "Select the field";
                                }
                              },
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Model",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              isExpanded: true,
                              iconEnabledColor: Color(0xFF008000),
                              value: controller.bikebreakdownmode,
                              items: bikemodel.map(buildmenu).toList(),
                              onChanged: (value) {
                                controller.bikebreakdownmodel(value);
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
                          child: DropdownButtonFormField(
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            validator: (values) {
                              if (values == null) {
                                return "Select a field";
                              }
                            },
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Year",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            isExpanded: true,
                            iconEnabledColor: Color(0xFF008000),
                            value: controller.bikebrekdown1,
                            // items: years.map(buildmenu).toList(),
                            onChanged: (value) {
                              controller.bikebreakdown1(value);
                            },
                            items: bikesyears.map((String value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
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
                    controller: issues,
                    validator: (values) {
                      if (values == null || values.isEmpty) {
                        return "Select a text";
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
                SizedBox(
                  height: 50,
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
                      if (_formKey.currentState!.validate()) {
                        await bikebreakdownform();
                        yourIndiePushSendingFunction();
                        Navigator.pop(context);
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

  bikebreakdownform() async {
    final currentuserid = FirebaseAuth.instance.currentUser!.uid;
    final controler = Get.put(Servicecontroller());
    bool expire = false;
    var user = FirebaseAuth.instance.currentUser;
    var collection = FirebaseFirestore.instance.collection('Users');
    var docSnapshot = await collection.doc(user!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      names = data?['Name'];

      print(names);
    }

    CollectionReference bikebrekdownform =
        FirebaseFirestore.instance.collection("Userform");
    return bikebrekdownform.add({
      "work": work.text,
      "Manufacture": controler.bikebrekdown.toString(),
      "model": controler.bikebreakdownmode.toString(),
      'year': controler.bikebrekdown1.toString(),
      "issues": issues.text,
      "owerid": userid,
      "location": location,
      "shopname": shopname,
      "ownername": ownername,
      "userlocation": controler.address.value,
      "username": names,
      "experied": expire,
      "currenuserid": currentuserid,
      "latitude": controler.latitude.value,
      "logitude": controler.longitude.value,
      "date": DateTime.now().millisecondsSinceEpoch
    }).then((value) => print("bikebreadform"));
  }

  void yourIndiePushSendingFunction() {
    NativeNotify.sendIndieNotification(472, 'qMMR6PMv5Lfht6dCRrmQzA', '4',
        'You have new request', '$names', null, null);
    // yourAppID, yourAppToken, 'your_sub_id', 'your_title', 'your_body' is required
    // put null in any other parameter you do NOT want to use
  }

  DropdownMenuItem<String> buildmenu(String item) => DropdownMenuItem(
      value: item,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          item,
          style: TextStyle(color: Color.fromARGB(255, 250, 250, 250)),
        ),
      ));
}
