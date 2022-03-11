import 'package:carousel_slider/carousel_slider.dart';
import 'package:carserv/contoller/controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Generalservice extends StatelessWidget {
  Generalservice({Key? key}) : super(key: key);
  final images = [
    "assets/ac5dd9fe4afdc1c69bc0f1f7edaa4713.jpg",
    "assets/Motorcycle-Breakdown.jpg"
  ];

  @override
  Widget build(BuildContext context) {
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
              "You need to Service your Vehicle.Don't worry we help you",
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
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
                    onTap: () {
                      Get.to(Generalform());
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
                                image: AssetImage(
                                    "assets/motorcycle-parts-garage-kitchen-blurry_151013-34169.webp"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.46,
                              child: Text(
                                "Company  service Time Duration 30 Hourpick from you and service",
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
                        Text(
                          "Krishna service",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Minimum Amount  ",
                                style: TextStyle(fontSize: 15)),
                            Text("₹100",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
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
            )
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

class Generalform extends StatelessWidget {
  Generalform({Key? key}) : super(key: key);
  final generalitems = [
    "item 1",
    "item 2",
    "item 3",
    "item 4",
    "item 5",
    "item 6",
    "item 7",
    "item 8"
  ];
  final bikeyears = [
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF738878),
          title: Text(
            "Enginework",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
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
                          Text("Generalwork form",
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
                                        "assets/ac5dd9fe4afdc1c69bc0f1f7edaa4713.jpg"),
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
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "GeneralWork",
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
                  padding:
                      EdgeInsets.only(top: 0, left: 50, right: 50, bottom: 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.black,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(color: Color(0xFF008000))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            hint: Text(
                              "Manufacture",
                              style: TextStyle(color: Colors.white),
                            ),
                            isExpanded: true,
                            iconEnabledColor: Color(0xFF008000),
                            value: controller.genarall,
                            items: generalitems.map(buildmenu).toList(),
                            onChanged: (value) {
                              controller.bikegenera(value);
                            }),
                      ),
                    ),
                  ),
                ),
              ),
              GetBuilder<Servicecontroller>(
                builder: (controller) => Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 50, right: 50, bottom: 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.black,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(color: Color(0xFF008000))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            hint: Text(
                              "Model",
                              style: TextStyle(color: Colors.white),
                            ),
                            isExpanded: true,
                            iconEnabledColor: Color(0xFF008000),
                            value: controller.genarall,
                            items: generalitems.map(buildmenu).toList(),
                            onChanged: (value) {
                              controller.bikegenera(value);
                            }),
                      ),
                    ),
                  ),
                ),
              ),
              GetBuilder<Servicecontroller>(
                builder: (controller) => Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 50, right: 50, bottom: 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.black,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(color: Color(0xFF008000))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(
                            "Year",
                            style: TextStyle(color: Colors.white),
                          ),
                          isExpanded: true,
                          iconEnabledColor: Color(0xFF008000),
                          value: controller.genalralyear,
                          // items: years.map(buildmenu).toList(),
                          onChanged: (value) {
                            controller.bikegenerayea(value);
                          },
                          items: bikeyears.map((String value) {
                            return DropdownMenuItem(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 250, 250, 250))));
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
              SizedBox(
                height: 50,
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
    DropdownMenuItem<String> buildmenu(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(color: Color.fromARGB(255, 250, 250, 250)),
      ));
}
