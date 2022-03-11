import 'package:carserv/contoller/controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trackmap extends StatelessWidget {
  Trackmap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          GetBuilder<Servicecontroller>(
            builder: (controller) => Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * .4,
              child: GoogleMap(
                mapType: MapType.normal,
                markers: controller.markers,
                onMapCreated: controller.map(),
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        controller.latitude.value, controller.longitude.value),
                    zoom: 10.0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Details", style: TextStyle(color: Colors.white, fontSize: 25)),
          SizedBox(
            height: 30,
          ),
          listforms("Complaints"),
          SizedBox(
            height: 10,
          ),
          listforms("Date"),
          SizedBox(
            height: 10,
          ),
          listforms("Sparechange"),
          SizedBox(
            height: 10,
          ),
          listforms("Amount"),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 180,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF62A769)),
              ),
              onPressed: () {},
              child: Text(
                "Pay",
                style: TextStyle(
                    color: Colors.black, fontSize: 20, letterSpacing: 1),
              ),
            ),
          )
        ],
      ),
    ));
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
