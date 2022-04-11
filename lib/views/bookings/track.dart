import 'dart:convert';
import 'dart:math';

import 'package:carserv/contoller/controler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:oktoast/oktoast.dart';

class Trackmap extends StatefulWidget {
  Trackmap(
      {Key? key,
      required this.index,
      required this.latitude,
      required this.longitude,
      required this.complaint,
      required this.shopname,
      required this.work,
      required this.ownername,
      required this.curretuserid})
      : super(key: key);
  int index;
  var latitude;
  var longitude;
  var complaint;
  var shopname;
  var curretuserid;
  var work;
  var ownername;

  @override
  State<Trackmap> createState() => _TrackmapState();
}

class _TrackmapState extends State<Trackmap> {
  late Razorpay razorpay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerpaymentsuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerpaymenterror);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerextenalwaltet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  handlerpaymentsuccess(PaymentSuccessResponse response) {
    final controler = Get.put(Servicecontroller());
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId.toString(),
        timeInSecForIosWeb: 4);
    CollectionReference billform =
        FirebaseFirestore.instance.collection("Bills");
    return billform.add({
      "nameofowner": widget.ownername,
      "shopname": widget.shopname,
      "paymentoption": "online",
      "work": widget.work,
      "amount": controler.amount,
      "userid": widget.curretuserid,
      "sparechanged": controler.sparechanged,
      "date": DateFormat('dd-MM-yyyy').format(DateTime.now())
    }).then((value) => print("billadded"));
  }

  handlerpaymenterror() {
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2");
  }

  handlerextenalwaltet() {
    print("########################################");
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Servicecontroller());
    //  getlatitide();
    return SafeArea(
        child:
            Scaffold(backgroundColor: Colors.black, body: Trackbody(context)));
  }

  Column Trackbody(BuildContext context) {
    return Column(children: [
      GetBuilder<Servicecontroller>(
        // initState: (state) => controller.map(),
        builder: (controller) => Container(
          color: Colors.blue,
          height: MediaQuery.of(context).size.height * .4,
          child: GoogleMap(
            mapType: MapType.normal,
            markers: controller.markers,
            onMapCreated:
                controller.map(lat: widget.latitude, long: widget.longitude),
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    controller.latitude.value, controller.longitude.value),
                zoom: 10.0),
          ),
        ),
      ),
      StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('Amountform').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }

            if (snapshot.data!.docs.length <= widget.index) {
              return Center(
                child: Text(
                  "No details is updated",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }

            final details = snapshot.data!.docs[widget.index];

            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Details",
                    style: TextStyle(color: Colors.white, fontSize: 25)),
                SizedBox(
                  height: 30,
                ),
                listforms(details['workdone']),
                SizedBox(
                  height: 10,
                ),
                listforms(details['date']),
                SizedBox(
                  height: 10,
                ),
                listforms(details['sparechange']),
                SizedBox(
                  height: 10,
                ),
                listforms(details['amount']),
                SizedBox(
                  height: 20,
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
                      openchek(details['amount']);
                    },
                    child: Text(
                      "Pay",
                      style: TextStyle(
                          color: Colors.black, fontSize: 20, letterSpacing: 1),
                    ),
                  ),
                )
              ],
            );

            // 
          }),
    ]);
  }

  void openchek(amount) {
    RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
    double money = double.parse(amount);
    double tMoney = money * 100;
    String stringMoney = tMoney.toString().replaceAll(regex, '');
    int totalMoney = int.parse(stringMoney);

    var options = {
      "key": "rzp_test_wZ0NaTrGU0FvIV",
      "amount": totalMoney,
      "external": {
        "wallets": ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  Container listforms(String txt) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.only(right: 20.0, left: 20),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(border: Border.all(color: Color(0xFF008000))),
      child: Text(
        txt,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
