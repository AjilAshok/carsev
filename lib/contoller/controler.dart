import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Servicecontroller extends GetxController {
  String? value;
  String? value1;
  String? valueoil;
  String? valueoil1;
  String? valueengine;
  String? valueengine1;
  String? genarall;
  String? genalralyear;
  String? bikebrekdown;
  String? bikebrekdown1;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var address = ''.obs;
  late StreamSubscription<Position> streamSubscription;
  final Set<Marker> markers = {};

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
  }

  map() {
    markers.add(Marker(
      
      markerId: MarkerId("id-1"),
      position: LatLng(latitude.value,longitude.value),
       infoWindow: InfoWindow(
      title:address.value
      )
      
    ));
  }

  
}
