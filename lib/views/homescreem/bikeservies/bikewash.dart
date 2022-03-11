import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Bikewash extends StatelessWidget {
   Bikewash({ Key? key }) : super(key: key);
   final images=[
     "assets/ee559e05067b84b3f6b0c83b70b9fe1b.jpg",
     "assets/bike-washing-service-500x500.jpg"
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
              "Need to Service your bike ",
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
                  Get.to(Bikewashform());
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
                          child: Image(image: AssetImage("assets/istockphoto-1179753682-612x612.jpg"),fit: BoxFit.cover,),
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
                    Text("Bike Service",style: TextStyle(fontSize:25,fontWeight: FontWeight.bold ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Amount  ",style: TextStyle(fontSize: 15) ),
                          Text("₹340",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold) ),
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
class Bikewashform extends StatelessWidget {
  const Bikewashform({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF738878),
          title: Text(
            "Bikewash",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
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
                      SizedBox(
                        height: 70,
                      ),
                      Row(
                        children: [
                          Text("Registeration form",
                              style: GoogleFonts.rokkitt(
                                  color: Color(0XFF72E77E), fontSize: 25)),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: 140,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/bike-washing-service-500x500.jpg"),
                                    fit: BoxFit.cover)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Name",
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
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 50, right: 50),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Messsage",
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
              SizedBox(
                height: 70,
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
    );
  }
}