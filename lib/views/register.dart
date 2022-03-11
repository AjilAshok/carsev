import 'package:flutter/material.dart';

class Registeraion extends StatelessWidget {
  const Registeraion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3D433E),
      body: SingleChildScrollView(
        child: Column(
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                image: DecorationImage(image:AssetImage("assets/1b3f3e2ac8d54e252aaf4bf798e9dbfa--motorcycle-mechanic-motorcycle-logo.jpg"),fit: BoxFit.cover ),

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
              padding: const EdgeInsets.only(left: 40,right: 40),
              child: TextFormField(
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
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0XFF62A769))),
                onPressed: (){}, child:Text("Register",style: TextStyle(color: Colors.black,fontSize:20 ),)),
            )
          ],
        ),
      ),
    );
  }
}
