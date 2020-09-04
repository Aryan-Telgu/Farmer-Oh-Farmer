import 'package:farmer_oh_farmer/Style.dart';
import 'package:flutter/material.dart';
import 'package:farmer_oh_farmer/ShoppingPage/ShoppingMainPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg_image.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 35,
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              centerTitle: true,
              title: Image(
                image: AssetImage('assets/home_logo.png'),
                width: 100,
              ),
              actions: [
                Image(image: AssetImage('assets/cart_logo.png')),
              ]),
          drawer: Drawer(
            child: Container(
              color: themeColorGreen[800],
              child: ListView(children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text("Rutwik", style: blackText),
                  accountEmail:
                      new Text("rutwik.shete@gmail.com", style: blackText),
                  currentAccountPicture: new CircleAvatar(
                    backgroundImage: new NetworkImage(
                        "https://instagram.fnag1-3.fna.fbcdn.net/v/t51.2885-15/sh0.08/e35/s640x640/118648860_2648340292050012_4863397966211105654_n.jpg?_nc_ht=instagram.fnag1-3.fna.fbcdn.net&_nc_cat=100&_nc_ohc=U7INHXKBnqcAX-a2s45&oh=7c4fdc6ba4e95a5c2b3b466480a0a59e&oe=5F7C326B"),
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                ),
                new ListTile(
                  title: new Text(
                    "LogOut",
                    style: whiteText,
                  ),
                ),
              ]),
            ),
          ),
          body: Container(
            child : Column(
              children : <Widget> [
                ShoppingPage(),
              ]
            )
          ),
          ),
    );
  }
}
