import 'package:carousel_slider/carousel_slider.dart';
import 'package:carserv/contoller/controler.dart';
import 'package:carserv/views/homescreem/widgets/breakdownform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Breakdown extends StatelessWidget {
  Breakdown({Key? key}) : super(key: key);
  final images = ["assets/services.png", "assets/work-2.png"];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Servicecontroller());
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
                    .where("type", isEqualTo: "Car")
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
                      controller.latitude.value,
                      controller.longitude.value,
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

                        final sortedOwnerMap = sortedOwnerList[index];

                        return InkWell(
                          onTap: () {
                            Get.to(
                              Breakdownform(
                                userid: sortedOwnerMap['ownerId'],
                                shopname: sortedOwnerMap['shopName'],
                                ownername: sortedOwnerMap['ownerName'],
                                location: sortedOwnerMap['location'],
                              ),
                            );
                          },
                          child: Column(
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
                              //  Divider(
                              //   thickness: 1,
                              //   color: Colors.black,
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    sortedOwnerMap['shopName'],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${sortedOwnerMap['distance'].round()} KM',
                                    style: TextStyle(
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
