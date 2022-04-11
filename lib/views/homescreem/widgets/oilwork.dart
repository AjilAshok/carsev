import 'package:carousel_slider/carousel_slider.dart';
import 'package:carserv/contoller/controler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final currentuserid = FirebaseAuth.instance.currentUser!.uid;

class Oilwork extends StatelessWidget {
  Oilwork({Key? key}) : super(key: key);
  final images = ["assets/slider-bg.jpg", "assets/details-dec-2.jpg"];

  @override
  Widget build(BuildContext context) {
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
                    .where("chekbox", arrayContains: "Oilchange")
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
                        //  print( ownerdetails['showname']);

                        return InkWell(
                          onTap: () {
                            Get.to(Oilform(
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
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.46,
                                    child: Text(
                                      "Company  service Time Duration 30 Hourpick from your home and service",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
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

class Oilform extends StatelessWidget {
  Oilform(
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
  final oilitesm = [
    "item 1",
    "item 2",
    "item 3",
    "item 4",
    "item 5",
    "item 6",
    "item 7",
    "item 8"
  ];
  final oilmodel = [
    "model 1",
    "model 2",
    "model 3",
    "model 4",
    "model 5",
    "model 6",
    "model 7",
    "model 8"
  ];
  final oilyears = [
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
  TextEditingController oilchange = TextEditingController();
  TextEditingController oilissues = TextEditingController();

  @override
  Widget build(BuildContext context) {
    oilchange.text = "Oilchange";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF738878),
          title: Text(
            "Oilchange",
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
                            Text("Oilchange form",
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
                    controller: oilchange,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Oilchange",
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
                              value: controller.valueoil,
                              items: oilitesm.map(buildmenu).toList(),
                              onChanged: (value) {
                                controller.oildromdown(value);
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
                              value: controller.valueyearoil,
                              items: oilmodel.map(buildmenu).toList(),
                              onChanged: (value) {
                                controller.oilchagnge(value);
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
                            value: controller.valueoil1,
                            // items: years.map(buildmenu).toList(),
                            onChanged: (value) {
                              controller.oildromdown1(value);
                            },
                            items: oilyears.map((String value) {
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
                    controller: oilissues,
                    validator: (Value) {
                      if (Value == null || Value.isEmpty) {
                        return "Enter some text";
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
                Container(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF62A769)),
                    ),
                    onPressed: () async {
                      final contoler = Get.find<Servicecontroller>();
                      if (contoler.valueoil != null) {
                        contoler.formvalide("Select a option", Colors.red);
                      }
                      if (contoler.valueoil1 != null) {
                        contoler.formvalide("Select a option", Colors.red);
                      }
                      if (contoler.valueyearoil != null) {
                        contoler.formvalide("Select a option", Colors.red);
                      }
                      if (_formKey.currentState!.validate()) {
                        await oilchangeform();
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

  DropdownMenuItem<String> buildmenu(String item) => DropdownMenuItem(
      value: item,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item,
          style: TextStyle(color: Color.fromARGB(255, 250, 250, 250)),
        ),
      ));

  oilchangeform() async {
      final controller = Get.find<Servicecontroller>();
    final oilchangecontrole = Get.put(Servicecontroller());
    bool expire = false;
    var name = '';
    var user = FirebaseAuth.instance.currentUser;
    var collection = FirebaseFirestore.instance.collection('Users');
    var docsnapshot = await collection.doc(user!.uid).get();
    if (docsnapshot.exists) {
      Map<String, dynamic>? data = docsnapshot.data();
      name = data?['Name'];

      // <-- The value you want to retrieve.
      //  print(value);

    }
    CollectionReference userform =
        FirebaseFirestore.instance.collection("Userform");
    return userform
        .add({
          "work": oilchange.text,
          "Manufacture": oilchangecontrole.valueoil.toString(),
          "model": oilchangecontrole.valueyearoil.toString(),
          "year": oilchangecontrole.valueoil1,
          "issues": oilchange.text,
          "owerid": userid,
          "location": location,
          "shopname": shopname,
          "ownername": ownername,
          "userlocation": oilchangecontrole.address.value,
          "username": name,
          "experied": expire,
          "currenuserid": currentuserid,
          "latitude":controller.latitude.value,
          "logitude":controller.longitude.value,
           "date":DateFormat('dd-MM-yyyy').format(DateTime.now())

        })
        .then((value) => print("useroilform"))
        .onError((error, stackTrace) => print(error));
  }
}
