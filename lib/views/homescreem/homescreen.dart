import 'package:carserv/contoller/controler.dart';
import 'package:carserv/views/homescreem/bikeservies/bikewash.dart';
import 'package:carserv/views/homescreem/bikeservies/breakdown.dart';
import 'package:carserv/views/homescreem/bikeservies/general.dart';
import 'package:carserv/views/homescreem/widgets/breakdown.dart';
import 'package:carserv/views/homescreem/widgets/carwash.dart';
import 'package:carserv/views/homescreem/widgets/enginework.dart';
import 'package:carserv/views/homescreem/widgets/oilwork.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Mainhomescreen extends StatelessWidget {
  Mainhomescreen({Key? key}) : super(key: key);
   String deviceTokenToSendPushNotification='';
   var user=FirebaseAuth.instance.currentUser;
   

  final images = [
    "https://media.istockphoto.com/photos/hands-of-car-mechanic-picture-id490048372?b=1&k=20&m=490048372&s=170667a&w=0&h=9wdQr-kSrbGaDMi7PzO9B0nBB9VfZWA00zL9UE3Dtqw=",
    "https://thumbs.dreamstime.com/b/worker-uniform-disassembles-vehicle-engine-car-service-station-automobile-checking-inspection-professional-diagnostics-173424972.jpg",
    "https://media.istockphoto.com/photos/checking-oil-in-car-engine-picture-id1157179147?k=20&m=1157179147&s=612x612&w=0&h=UKbu3rdN-53cmKSO8NvuNl5Ve7Lh29rsUkVeARnE87M="
  ];
  final stringimages = [
    "assets/A-Better-911-Engine-Singer-gear-patrol-1.jpg",
    "assets/slider-bg.jpg",
    "assets/page-banner-2.png",
    "assets/slider-bg.jpg"
  ];
  final texts = ["Engine Work", "Oil Work", "Car Wash", "Break Down"];
  final bikeimages = [
    "assets/ac5dd9fe4afdc1c69bc0f1f7edaa4713.jpg",
    "assets/ee559e05067b84b3f6b0c83b70b9fe1b.jpg",
    "assets/Motorcycle-Breakdown.jpg",
  ];
  final biketexts = ["General Work", "Bike Washing", "Break Down"];

  List pages = [ Enginework(), Oilwork(),Carwash(), Breakdown()];

  List bikepages=[ Generalservice(),Bikewash(),Breakdownbike()

  ];
  Future<void> getDeviceTokenToSendNotification() async {
    		final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    		final token = await _fcm.getToken();
    		deviceTokenToSendPushNotification = token.toString();
    		print("Token Value $deviceTokenToSendPushNotification");
  	}

  @override
  Widget build(BuildContext context) {
    print(user!.uid);

    
    getDeviceTokenToSendNotification();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Carserv",
          style: GoogleFonts.rye(fontSize: 30, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Color(0XFF738878),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 5),
                  GetBuilder<Servicecontroller>(
                    builder: (controller) => 
                     Obx(
                       () =>  Text(
                        controller.address.value,
                        style: GoogleFonts.montserrat(color: Colors.black),
                                         ),
                     ),
                  )
                ],
              ),
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
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Car Service",
                  style:
                      GoogleFonts.montserrat(color: Colors.black, fontSize: 25),
                )),
            SizedBox(
              height: 30,
            ),
            GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: stringimages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () => Get.to(pages[index]),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image: AssetImage(stringimages[index]),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 50,
                          child: Text(texts[index]))
                    ],
                  );
                }),
            Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  "Bike Service",
                  style:
                      GoogleFonts.montserrat(color: Colors.black, fontSize: 25),
                )),
            SizedBox(
              height: 30,
            ),
            GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: bikeimages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () =>Get.to(bikepages[index]),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image: AssetImage(bikeimages[index]),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 55,
                          child: Text(biketexts[index]))
                    ],
                  );
                }),
          ],
        ),
      ),
    ));
  }

  Widget buildimage(String image, int index) => Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        // color: Colors.red,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.fill)),
      );
}





