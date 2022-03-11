import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Color(0XFF738878),
              title: Text(
                "Contact Us",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Image.asset(
                  "assets/concept-shot-contact-us-board-car-contact-us-147744739.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.phone,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "Callus",
                      style: TextStyle(fontSize: 25, letterSpacing: 2),
                    )),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.mailchimp,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "Email Us",
                      style: TextStyle(fontSize: 25, letterSpacing: 2),
                    )),
                  ],
                ),
              ),
            ])));
  }
}
