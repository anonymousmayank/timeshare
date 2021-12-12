import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:timeshare/home.dart';

import 'package:device_preview/device_preview.dart';

import 'homepage.dart';

void main() {
  runApp(
    DevicePreview(
    enabled: true,
    builder: (context) => MyApp(), // Wrap your app
  ),
    );
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Widget home;
  bool checkingAuthState=true;

  void initState(){
  checkAuth();
    super.initState();
  }

  checkAuth() async{
    await Firebase.initializeApp();
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
      home=Home();
      setState(() {
        checkingAuthState=false;
      });
    } else {
      home=HomePage(currentTab: 0);
      setState(() {
        checkingAuthState=false;
      });
      print('User is signed in!');
    }
  });

  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Time Share',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: checkingAuthState?Scaffold():home,
    );
  }

}

