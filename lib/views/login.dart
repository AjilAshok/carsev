import 'dart:math';

import 'package:carserv/views/bootomnav/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_autofill/sms_autofill.dart';

FirebaseAuth auth = FirebaseAuth.instance;
TextEditingController userInput = TextEditingController();
TextEditingController otpInput = TextEditingController();
String Verifi = '';
// Future <String> error='';

class Loginpage extends StatelessWidget {
  Loginpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF3D433E),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.maxFinite,

              // color: Colors.red,
              child: Image(
                image: AssetImage("assets/gallery-6.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 40),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                controller: userInput,
                decoration: InputDecoration(
                  prefix: Text("(+91) "),
                  hintText: "Enter your number",
                  hintStyle: TextStyle(color: Colors.white),
                  // suffixIcon:IconButton(onPressed: (){
                  //    veriyingnumber();

                  // }, icon:Icon(Icons.add,color:Colors.white ,))
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 80,right: 80,top: 20),
            //   child: TextFormField(
            //      style: TextStyle(color: Colors.white),
            //       keyboardType: TextInputType.phone,
            //       controller: otpInput,
            //       decoration: InputDecoration(
            //         // prefix: Text("  "),
            //         hintText: "OTP",

            //          hintStyle: TextStyle(color: Colors.white)
            //       ),

            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.transparent),
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF62A769)),
                    ),
                    onPressed: () {
                      // verificycode(context);
                      veriyingnumber();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Verification(),
                          ));
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.black, fontSize: 20, letterSpacing: 1),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

void verificycode(ctx)async {
  PhoneAuthCredential credentiall = PhoneAuthProvider.credential(
      verificationId: Verifi, smsCode: otpInput.text);
 await auth.signInWithCredential(credentiall).then((value) {
  
  
    Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(
          builder: (context) => Homescreen(),
        ));
   }).catchError((e){

    
     
    //  error=e;
//  error="Invslid";
 
   
   });
 
}

void veriyingnumber() {
  auth.verifyPhoneNumber(
      phoneNumber: "+91" + userInput.text,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("login");
        });
      },
      verificationFailed: (FirebaseAuthException exoectin) {
        print(exoectin.message);
        // error=exoectin.message.toString();
      },
      codeSent: (String verificationId, int? resend) {
        Verifi = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {});
}

class Verification extends StatelessWidget {
   Verification({Key? key,}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0XFF3D433E),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 60),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: Colors.transparent),
                child: Lottie.network(
                  "https://assets4.lottiefiles.com/packages/lf20_qf1pt6ua.json",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Verifiy Your code",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(50),
              child: PinFieldAutoFill(
                controller: otpInput,
                codeLength: 6,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 50,
              width: 200,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0XFF62A769))),
                  onPressed: () {
                    verificycode(context);
                //  await   Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => Homescreen(),
                //         ));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                  onPressed: () {
                    veriyingnumber();
                    // print(error.toString());
                  },
                  child: Text("Resend the code",
                      style: TextStyle(color: Colors.white))),
                      
              // child: TextButton("Resend the Code",onPressed: (){

              // }, style: TextStyle(color:Colors.white),),
            ),
           
            // Text(,style: TextStyle(color: Colors.red),),
          
            
          ],
        ),
      ),
    ));
  }
  void showMessage(String errorMessage,ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        });
     
    print("Invalid otp");


   }
}
