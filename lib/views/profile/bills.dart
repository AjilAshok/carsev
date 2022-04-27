import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Bills extends StatelessWidget {
  const Bills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    print(userid);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        toolbarHeight: 60,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0XFF738878),
        title: Text(
          "Bills",
          style: GoogleFonts.montserrat(
              color: Colors.black, letterSpacing: 2, fontSize: 25),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Bills')
              .where("userid", isEqualTo: userid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("No Bills"),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                print(userid);
                final results = snapshot.data!.docs[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        results['nameofowner'],
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(results['shopname'], style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(results['paymentoption'],
                          style: TextStyle(fontSize: 20)),
                     
                      SizedBox(
                        height: 10,
                      ),
                      Text(results['work'], style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(results['sparechanged'],
                          style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(results['amount'], style: TextStyle(fontSize: 20)),
                      Divider(
                        thickness: 1,
                      )
                    ],
                  ),
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          }),
    ));
  }
  // createpdf()async{
  //   try {
  //      PdfDocument document=PdfDocument();
  //   document.pages.add();
  //   List <int> bytes=document.save();
  //   document.dispose();
  //     saveAndlaungFile(bytes,'sample.pdf');

  //   } catch (e) {
  //     print(e);
  //   }

  // }
}

class Invoice {}
