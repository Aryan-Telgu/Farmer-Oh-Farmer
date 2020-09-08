import 'package:farmer_oh_farmer/Style.dart';
import 'package:flutter/material.dart';
import 'package:farmer_oh_farmer/ShoppingPage/ShoppingMainPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  /*@override
  void initstate() {
    super.initState();
    //_iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.green,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: new AssetImage("assets/login_page_bg.png"),
            fit: BoxFit.cover,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //new FlutterLogo(
                  //size: _iconAnimation.value * 100,
                //) //I need to add home_logo.png
                //,
                Form(
                  child: new Column(children: <Widget>[
                    new TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Enter Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    new TextFormField(
                      decoration: new InputDecoration(
                        hintText: "Enter Password",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                    )
                  ]),
                )
              ])
        ],
      ),
    );
  }
}
