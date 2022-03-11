import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Carwashform extends StatelessWidget {
  const Carwashform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0XFF738878),
          title: Text(
            "Carwash",
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
                                        "assets/service-details.jpg"),
                                    fit: BoxFit.fill)),
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
