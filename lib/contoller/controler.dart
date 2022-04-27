import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Servicecontroller extends GetxController {
  String? value;
  String? brekdownmodel;
  String? value1;
  String? valueoil;
  String? valueoil1;
  String? valueengine;
  String? valueengine1;
  String? valuemodel;
  String? valueyearoil;
  String? genarall;
  String? genalralyear;
  String? bikebrekdown;
  String? bikebrekdown1;
  String? bikebreakdownmode;
  String? generalmodel;
  // var amount;
  // var sparechanged;
  RxDouble latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var address = ''.obs;
  late StreamSubscription<Position> streamSubscription;
  Set<Marker> markers = {};
  // String valid = 'Select a option';
  // Color color = Colors.white;

  int currenindex = 0;

  bottomnavbar(index) {
    currenindex = index;
    update();
  }

  dropdown(Value) {
    value = Value;
    update();
  }

  drowpdown1(Value1) {
    value1 = Value1;
    update();
  }

  drowpdown2(Value1) {
    brekdownmodel = Value1;
    update();
  }

  oildromdown(Valueoil) {
    valueoil = Valueoil;
    update();
  }

  oildromdown1(Valueoil1) {
    valueoil1 = Valueoil1;
    update();
  }

  Enginedromdown(Valueeng) {
    valueengine = Valueeng;
    update();
  }

  Enginedromdown1(Valueeng1) {
    valueengine1 = Valueeng1;
    update();
  }

  engienmodel(Valueeng1) {
    valuemodel = Valueeng1;
    update();
  }

  oilchagnge(Valuees) {
    valueyearoil = Valuees;
    update();
  }

  // bikeServies-----------

  bikegenera(general) {
    genarall = general;
    update();
  }

  bikegenerayea(generalyear) {
    genalralyear = generalyear;
    update();
  }

  bikebreakdown(bikebreakvalue) {
    bikebrekdown = bikebreakvalue;
    update();
  }

  bikebreakdown1(bikebreakvalue1) {
    bikebrekdown1 = bikebreakvalue1;
    update();
  }
  bikebreakdownmodel(bikebreakdownmodelvalues){
    bikebreakdownmode=bikebreakdownmodelvalues;
    update();



  }
  generialmodel(generalmodels){
    generalmodel=generalmodels;
    update();

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getlocation();
  }

  getlocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      getaddress(position);
    });
  }

  getaddress(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address.value = '${place.locality},${place.country}';
    // print(position.longitude);
    // print(position.longitude);
    getdistance(position);
  
  }

  map({required lat,required long} ) {
    markers.add(Marker(
        markerId: MarkerId("id-1"),
        position: LatLng(latitude.value, longitude.value),
        infoWindow: InfoWindow(title: address.value)));
        markers.add(Marker(
        markerId: MarkerId("id-2"),
        position: LatLng(lat,long),
        infoWindow: InfoWindow(title: "Owner")));
      //   print("**********************");
      //  print(lat);
      //  update();

  }
  double distanceinmeterr=0.0;
  double endlat=63.92384000338432;
  double englong=-113.01409766077995;

  List a = [10,20,30];

  

 Future getdistance(Position position)async{
    distanceinmeterr= Geolocator.distanceBetween(position.latitude,position.longitude,63.92384000338432, -113.01409766077995);
    var distance=distanceinmeterr.round().toInt();
  //   print(distance);
  //   print("${distance.round()/1000}Km");
  // List b =  a.where((element) => element >= 20).toList();

  //   print(b);
  }
  
}
