import 'package:carserv/contoller/controler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:native_notify/native_notify.dart';

class Breakdownform extends StatelessWidget {
  Breakdownform(
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
  final currentuserid = FirebaseAuth.instance.currentUser!.uid;
      var name = '';

  final itesm = [
    "item 1",
    "item 2",
    "item 3",
    "item 4",
    "item 5",
    "item 6",
    "item 7",
    "item 8"
  ];
  final brekdownmodel = [
    "model 1",
    "model 2",
    "model 3",
    "model 4",
    "model 5",
    "model 6",
    "model 7",
    "model 8"
  ];
  final years = [
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
  final brekdowncontroler = Get.put(Servicecontroller());
  TextEditingController workcontoler = TextEditingController();
  TextEditingController issuescontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    workcontoler.text = "Breakdown";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF738878),
          title: Text(
            "Breakdown",
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
                    controller: workcontoler,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter some text";
                      }
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Brekdown",
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
                              decoration: InputDecoration(
                            border: InputBorder.none
                          ),
                              validator: (values){
                              if (values==null) {
                                return "Select a option";
                                
                              }
                            },
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Manufacture",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              isExpanded: true,
                              iconEnabledColor: Color(0xFF008000),
                              value: controller.value,
                              items: itesm.map(buildmenu).toList(),
                              onChanged: (value) {
                                controller.dropdown(value);
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
                              decoration: InputDecoration(
                            border: InputBorder.none
                          ),
                              validator: (values){
                              if (values==null) {
                                return "Select a option";
                                
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
                              value: controller.brekdownmodel,
                              items: brekdownmodel.map(buildmenu).toList(),
                              onChanged: (value) {
                                controller.drowpdown2(value);
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
                              decoration: InputDecoration(
                            border: InputBorder.none
                          ),
                            validator: (values){
                              if (values==null) {
                                return "Select a option";
                                
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
                            value: controller.value1,
                            // items: years.map(buildmenu).toList(),
                            onChanged: (value) {
                              controller.drowpdown1(value);
                            },
                            items: years.map((String value) {
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
                    controller: issuescontroler,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter the some text";
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
                // Padding(
                //   padding: EdgeInsets.all(8),
                //   child: GetBuilder<Servicecontroller>(
                //       builder: (controller) => Text(
                //             controller.valid.toString(),
                //             style: TextStyle(color: controller.color),
                //           )),
                // ),
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
                      final contorler = Get.put(Servicecontroller());
                     
                      if (_formKey.currentState!.validate()) {
                        yourIndiePushSendingFunction();
                        await breakdownform();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.black, fontSize: 20, letterSpacing: 1),
                    ),
                  ),
                ),
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
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          item,
          style: TextStyle(color: Color.fromARGB(255, 250, 250, 250)),
        ),
      ));
  breakdownform() async {
    bool expire = false;


    var user = FirebaseAuth.instance.currentUser;
    var collection = FirebaseFirestore.instance.collection('Users');
    var docSnapshot = await collection.doc(user!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      name = data?['Name'];
      print(name);
      // <-- The value you want to retrieve.
      //  print(value);

    }
    final controller = Get.find<Servicecontroller>();
    CollectionReference userform =
        FirebaseFirestore.instance.collection("Userform");
    return userform.add({
      "work": workcontoler.text,
      "Manufacture": controller.value.toString(),
      "model": controller.value1.toString(),
      "year": controller.brekdownmodel.toString(),
      "issues": issuescontroler.text,
      "owerid": userid,
      "location": location,
      "shopname": shopname,
      "ownername": ownername,
      "userlocation": controller.address.value,
      "username": name,
      "experied": expire,
      "currenuserid": currentuserid,
      "latitude": controller.latitude.value,
      "logitude": controller.longitude.value,
      "date":DateFormat('dd-MM-yyyy').format(DateTime.now())
    }).then((value) => print("userbreakdownform"));
  }
  void yourIndiePushSendingFunction() {
    
    NativeNotify.sendIndieNotification(472, 'qMMR6PMv5Lfht6dCRrmQzA', '4', 'You have new request', '$name', null, null);
    // yourAppID, yourAppToken, 'your_sub_id', 'your_title', 'your_body' is required
    // put null in any other parameter you do NOT want to use
}
}
