import 'package:farmer_oh_farmer/Constants.dart';
import 'package:farmer_oh_farmer/HomePage/HomeMainPage.dart';
import 'package:farmer_oh_farmer/Models/Customer.dart';
import 'package:farmer_oh_farmer/SignUpPage/SignUpMainPage.dart';
import 'package:flutter/material.dart';
import 'package:farmer_oh_farmer/Style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toast/toast.dart';

import '../Transitions.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String email = "";
  String password = "";
  bool isLoading = false;

  Future<String> loginCustomer() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await http.post(Uri.encodeFull(loginApi),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"email": email, "password": password}));
      Customer customer = Customer.fromJson(json.decode(response.body));
      if (customer.status == SUCCESSFLAG) {
        await customer.result.saveCustomerDataLocally();
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushReplacement(BouncyNavigation(HomePage()));
      } else if (customer.status == FAILEDFLAG) {
        Toast.show(customer.message, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
        enabled: !isLoading,
        onChanged: (value) => email = value,
        obscureText: false,
        style: style,
        decoration: loginPageInputDecoration("Email Address"));

    final passwordField = TextField(
      enabled: !isLoading,
      onChanged: (value) => password = value,
      obscureText: true,
      style: style,
      decoration: loginPageInputDecoration("Password"),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF6C8E0A),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: isLoading ? null : loginCustomer,
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                "Login",
                textAlign: TextAlign.center,
                style: style.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
    final newuserButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF6C8E0A),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: isLoading
            ? null
            : () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpPage();
                    },
                  ),
                );
              },
        child: Text("New User ?",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/login_page_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(36.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 100),
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/home_logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 30.0),
                emailField,
                SizedBox(height: 30),
                passwordField,
                SizedBox(height: 60),
                loginButon,
                SizedBox(height: 30),
                newuserButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
