import 'package:carousel_slider/carousel_slider.dart';
import 'package:carserv/views/homescreem/widgets/carwashform.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              // physics: NeverScrollableScrollPhysics(),
               
              itemCount: 5,
              itemBuilder: (context, index) {
              
              return InkWell(
                onTap: (){
                  Get.to(Carwashform());
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
                          width: MediaQuery.of(context).size.width/2,
                          color: Colors.green,
                          child: Image(image: AssetImage("assets/gallery-7.jpg"),fit: BoxFit.cover,),
                        ),
                       
                        Container(
                          width: MediaQuery.of(context).size.width*0.46,
                          child: Text("Company  service Time Duration 1 Hourpick from your home and service",style: TextStyle(fontSize: 20),),
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
                    Text("Car Service",style: TextStyle(fontSize:25,fontWeight: FontWeight.bold ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Amount  ",style: TextStyle(fontSize: 15) ),
                          Text("₹540",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ),
                      ],
                    ),
                       Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
              
                   
                  ],
                ),
              );
            },),
          )
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