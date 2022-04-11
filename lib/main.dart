import 'package:carserv/views/Splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:native_notify/native_notify.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  
   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
 
  
  
  
  
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: Splashscreen(),
    );
  }
}
