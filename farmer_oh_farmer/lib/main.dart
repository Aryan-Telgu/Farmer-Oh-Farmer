import 'dart:convert';

import 'package:farmer_oh_farmer/HomePage/HomeMainPage.dart';
import 'package:farmer_oh_farmer/Models/Customer.dart';
import 'package:farmer_oh_farmer/Style.dart';
import 'package:farmer_oh_farmer/Transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toast/toast.dart';

import 'LoginPage/LoginMainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController _imageRotationController;
  Animation<double> _animation;

  Future<String> _checkIfAlreadyLoggedIn() async {
    startAnimation();
    await Future.delayed(Duration(seconds: 4));
    final customerInfo = new FlutterSecureStorage();
    bool customerIdExists = await customerInfo.containsKey(key: "CustomerId");
    String customerName = await customerInfo.read(key: "CustomerName");
    print(customerName);
    if (customerIdExists)
      return "True";
    else
      return "False";
  }

  Future startAnimation(){
     _imageRotationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _imageRotationController,
      curve: Curves.elasticOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: customThemeGreen,
      ),
      home: FutureBuilder<String>(
        future:
            _checkIfAlreadyLoggedIn(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            if (snapshot.data == "True")
              child = HomePage();
            else
              child = LoginPage();
          } else if (snapshot.hasError) {
            print(snapshot.error);
          } else {
            child = Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg_image.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/fruit_basket.png"),
                    SizedBox(height: 100),
                    RotationTransition(
                      turns: _animation,
                      child: Image.asset("assets/splash_logo.png"),
                    ),
                  ],
                ),
              ),
            );
          }
          return child;
        },
      ),
    );
  }
  // return Container(
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //         image: AssetImage("assets/bg_image.png"),
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //     child: Container(
  //       padding: EdgeInsets.all(30),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Image.asset("assets/fruit_basket.png"),
  //           SizedBox(height: 100),
  //           RotationTransition(
  //             turns: _animation,
  //             child: Image.asset("assets/splash_logo.png"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
}
