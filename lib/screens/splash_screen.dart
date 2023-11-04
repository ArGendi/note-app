import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkNavigation(){
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if(user != null){
  //     // Navigate -> home screen
  //   }
  //   else{
  //     // Navigate -> login screen
  //   }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () { 
      checkNavigation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}