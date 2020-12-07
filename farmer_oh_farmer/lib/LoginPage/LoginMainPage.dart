import 'package:farmer_oh_farmer/SignUpPage/SignUpMainPage.dart';
import 'package:flutter/material.dart';

 class LoginPage extends StatefulWidget {
      LoginPage({Key key, this.title}) : super(key: key);
      final String title;
      @override
      LoginPageState createState() => LoginPageState();
    }
    class LoginPageState extends State<LoginPage> {
      TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

      @override
      Widget build(BuildContext context) {

        final emailField = TextField(
          obscureText: false,
          style: style,
          decoration: InputDecoration(
            filled: true,
              fillColor: Colors.white70,
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Email Address",
              hintStyle: TextStyle(fontSize: 22.0, color: Colors.black54),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: BorderSide(width: 1,color: Colors.grey))),
        );
        final passwordField = TextField(
          obscureText: true,
          style: style,
          decoration: InputDecoration(
            filled: true,
              fillColor: Colors.white70,
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "Password",
              hintStyle: TextStyle(fontSize: 22.0, color: Colors.black54),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: BorderSide(width: 1,color: Colors.grey))),
        );
        final loginButon = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFF6C8E0A),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {},
            child: Text("Login",
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
                      SizedBox(height: 10),
                      SizedBox(height: 30.0),
                      passwordField,
                      SizedBox(height: 10),
                      SizedBox(
                        height: 30.0,
                      ),
                      loginButon,
                      SizedBox(height: 10),
                      SizedBox(
                        height: 15.0,
                      ),
                      AlreadyHaveAnAccountCheck(
                        press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context){
                        return SignUpPage();
                      },
                    ),
                      );
                        },
                      ),      
                    ],
          ),
                ),
        ),
       ),
       );
      }
    }

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true, 
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: <Widget>[
          Text(
            login ? "New User ? ": "Have Account ?",
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold, backgroundColor: Colors.white10)
          ),
          GestureDetector(
                      onTap: press,
                                          child: Text(
                              login ?" Sign Up": " Sign In",
                              style: TextStyle(color: Color(0xFF6C8E0A),fontSize: 25, fontWeight: FontWeight.bold, backgroundColor: Colors.white10), 
                            ),
                    )
        ]
    );
  }
}

