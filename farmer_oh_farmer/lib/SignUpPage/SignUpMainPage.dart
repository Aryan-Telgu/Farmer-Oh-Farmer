import 'package:farmer_oh_farmer/HomePage/HomeMainPage.dart';
import 'package:farmer_oh_farmer/LoginPage/LoginMainPage.dart';
import 'package:farmer_oh_farmer/Models/Customer.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import '../Constants.dart';
import '../Transitions.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController pincodeController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  String name = "";
  String email = "";
  String phone = "";
  String password = "";
  String pincode = "";
  String address = "";
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateField() {
    if (_formKey.currentState.validate()) {
      signUpCustomer();
    }
  }

  Future<void> signUpCustomer() async {
    print(name + email + phone + password + pincode + address);
    setState(() {
      isLoading = true;
    });
    try {
      var response = await http.post(Uri.encodeFull(signUpApi),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "name": name,
            "phone": phone,
            "email": email,
            "password": password,
            "pincode": pincode,
            "address": address
          }));
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
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget nameField() {
    return TextFormField(
      controller: nameController,
      enabled: !isLoading,
      onChanged: (value) => name = value,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          hintStyle: TextStyle(fontSize: 22.0, color: Colors.black54),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(width: 1, color: Colors.grey))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: emailController,
      enabled: !isLoading,
      onChanged: (value) => email = value,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email Address",
          hintStyle: TextStyle(fontSize: 22.0, color: Colors.black54),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(width: 1, color: Colors.grey))),
      validator: MultiValidator([
        RequiredValidator(errorText: "Email cannot be Empty"),
        EmailValidator(errorText: 'enter a valid email address'),
      ]),
    );
  }

  Widget phoneField() {
    return TextFormField(
      controller: phoneController,
      enabled: !isLoading,
      onChanged: (value) => phone = value,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Phone",
          hintStyle: TextStyle(fontSize: 22.0, color: Colors.black54),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(width: 1, color: Colors.grey))),
      validator: validatephone,
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: passwordController,
      enabled: !isLoading,
      onChanged: (value) => password = value,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          hintStyle: TextStyle(fontSize: 22.0, color: Colors.black54),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(width: 1, color: Colors.grey))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter Password';
        }
        return null;
      },
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Confirm Password",
          hintStyle: TextStyle(fontSize: 22.0, color: Colors.black54),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(width: 1, color: Colors.grey))),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please re-enter your Password';
        }
        if (passwordController.text != confirmPasswordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
    );
  }

  Widget signUpButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF6C8E0A),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: isLoading ? null : validateField,
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                "SignUp",
                textAlign: TextAlign.center,
                style: style.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget pincodeField() {
    return TextFormField(
      controller: pincodeController,
      enabled: !isLoading,
      onChanged: (value) => pincode = value,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Pincode",
          hintStyle: TextStyle(fontSize: 22.0, color: Colors.black54),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(width: 1, color: Colors.grey))),
      validator: validatepin,
    );
  }

  Widget addressField() {
    return TextFormField(
      controller: addressController,
      enabled: !isLoading,
      onChanged: (value) => address = value,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Address",
          hintStyle: TextStyle(fontSize: 22.0, color: Colors.black54),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(width: 1, color: Colors.grey))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  Widget haveaccountButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xFF6C8E0A),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginPage();
              },
            ),
          );
        },
        child: Text("Have Account ?",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  String validatepin(value) {
    if (value.isEmpty) {
      return "Please enter a Pincode";
    } else if (value.length < 6 || value.length > 6) {
      return "Please enter a valid Pincode";
    } else {
      return null;
    }
  }

  String validatephone(value) {
    if (value.isEmpty) {
      return "Please enter Phone Number";
    } else if (value.length < 10 || value.length > 10) {
      return "Please enter a valid Phone Number";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/home_logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      nameField(),
                      SizedBox(height: 15.0),
                      emailField(),
                      SizedBox(height: 15.0),
                      phoneField(),
                      SizedBox(height: 15.0),
                      passwordField(),
                      SizedBox(height: 15.0),
                      confirmPasswordField(),
                      SizedBox(height: 15.0),
                      pincodeField(),
                      SizedBox(height: 15.0),
                      addressField(),
                      SizedBox(
                        height: 15.0,
                      ),
                      signUpButton(),
                      SizedBox(
                        height: 15.0,
                      ),
                      haveaccountButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
