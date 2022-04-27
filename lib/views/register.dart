import 'package:carserv/views/bootomnav/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:native_notify/native_notify.dart';

class Registeraion extends StatelessWidget {
  Registeraion({Key? key}) : super(key: key);
  TextEditingController name = TextEditingController();
  TextEditingController gmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var firebaseuser = FirebaseAuth.instance.currentUser;
    CollectionReference user = FirebaseFirestore.instance.collection('Users');
    Future<void> adduser() {
      return user
          .doc(firebaseuser!.uid.toString())
          .set({"Name": name.text, "email": gmail.text,"phonenumber":firebaseuser.phoneNumber, "date":DateTime.now().millisecondsSinceEpoch})
          .then((value) => print("user added"))
          .catchError((error) => print(error));
    }

    return Scaffold(
      backgroundColor: Color(0xFF3D433E),
      body: Form(
        key:_formKey ,
        child: SingleChildScrollView(
          child: Column(
            verticalDirection: VerticalDirection.down,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/1b3f3e2ac8d54e252aaf4bf798e9dbfa--motorcycle-mechanic-motorcycle-logo.jpg"),
                        fit: BoxFit.cover),
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: name,
                    validator: (val){
                    if(val==null||val.isEmpty){
                      return "Enter the name";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              //  SizedBox(
              //   height: 50,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  validator: (val){
                    if(val==null||val.isEmpty){
                      return "Enter the email";
                    }
                  },
                  controller: gmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0XFF62A769))),
                    onPressed: () {

                      if(_formKey.currentState!.validate()){
                        // yourLoginFunction();
                          adduser();
                      Get.off(Homescreen());
                      gmail.clear();
                      name.clear();

                      }
                    
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
 
}
