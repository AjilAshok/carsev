import 'package:carousel_slider/carousel_slider.dart';
import 'package:carserv/contoller/controler.dart';
import 'package:carserv/views/homescreem/widgets/carwashform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class Carwash extends StatelessWidget {
  Carwash({Key? key}) : super(key: key);
  final images = [
    "assets/page-banner-2.png",
    "assets/service-details.jpg",
    "assets/gallery-7.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final controler=Get.put(Servicecontroller());
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
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
          Container(
            child: Text(
              "Need to Service your car ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Owner')
                  .where("type", isEqualTo: "Car")
                  .where('chekbox', arrayContains: "Washing")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshotshot) {
                if (snapshotshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshotshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No owners'),
                  );
                }
                 List<Map> ownerDetails = [];
                  List distance = [];

                  for (int i = 0; i < snapshotshot.data!.docs.length; i++) {
                   
                    final doubledistacne = Geolocator.distanceBetween(
                      controler.latitude.value,
                      controler.longitude.value,
                      snapshotshot.data!.docs[i]['latitude'],
                      snapshotshot.data!.docs[i]['longitude'],
                    );

                    ownerDetails.add({
                      'distance': doubledistacne.round().toInt() / 1000,
                      'shopName': snapshotshot.data!.docs[i]['showname'],
                      'ownerName': snapshotshot.data!.docs[i]['ownername'],
                      'location': snapshotshot.data!.docs[i]['location'],
                      'ownerId': snapshotshot.data!.docs[i].id,
                    });
                  }

                  List sortedOwnerList = [
                    for (var e in ownerDetails)
                      if (e["distance"] < 15) e
                  ];

                  print(sortedOwnerList);

                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    // physics: NeverScrollableScrollPhysics(),

                    itemCount: sortedOwnerList.length,
                    itemBuilder: (context, index) {
                      final washdetails = snapshotshot.data!.docs[index];
                       var location=washdetails['location'];
                      //  print(location);
                        final sortedOwnerMap = sortedOwnerList[index];


                      return InkWell(
                        onTap: () {
                          Get.to(Carwashform(userid:  sortedOwnerMap['ownerId'],
                          shopname: sortedOwnerMap['shopName'],
                          ownername:sortedOwnerMap['ownerName'],
                          location:sortedOwnerMap['location']

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
                                  width: MediaQuery.of(context).size.width / 2,
                                  color: Colors.green,
                                  child: Image(
                                    image: AssetImage("assets/gallery-7.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  child: Text(
                                    """Company  service Time Duration 1 Hourpick from your home and service
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                 sortedOwnerMap['shopName'],
                                  style: TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold),
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
                                Text("Amount  ",
                                    style: TextStyle(fontSize: 15)),
                                Text("₹540",
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
    ));
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
