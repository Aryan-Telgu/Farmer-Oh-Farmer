import 'package:farmer_oh_farmer/CartPage/CartMainPage.dart';
import 'package:farmer_oh_farmer/LoginPage/LoginMainPage.dart';
import 'package:farmer_oh_farmer/Models/Customer.dart';
import 'package:farmer_oh_farmer/Product/ProductCard.dart';
import 'package:farmer_oh_farmer/Style.dart';
import 'package:farmer_oh_farmer/Transitions.dart';
import 'package:flutter/material.dart';
import 'package:farmer_oh_farmer/ShoppingPage/ShoppingMainPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ShoppingOrCart whichPage = ShoppingOrCart.SHOPPING;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: customThemeGreen,
        accentColor: customThemeGreen[900],
      ),
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_image.png"),
            fit: BoxFit.cover,
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
                InkWell(
                  child: Image(
                    image: whichPage == ShoppingOrCart.SHOPPING
                        ? AssetImage('assets/cart_logo.png')
                        : AssetImage('assets/back_button.png'),
                  ),
                  onTap: toggleWhichPage,
                ),
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
                        "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.1ttGsbftpt0gIqIjA13sVwHaFj%26pid%3DApi&f=1"),
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                ),
                new ListTile(
                  onTap: () {
                    Result customer = new Result();
                    customer.deleteCustomerDataLocally();
                    Navigator.of(context)
                        .pushReplacement(BouncyNavigation(LoginPage()));
                  },
                  title: new Text(
                    "LogOut",
                    style: whiteText,
                  ),
                ),
              ]),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: whichPage == ShoppingOrCart.SHOPPING
                ? ShoppingPage()
                : CartPage(),
          ),
        ),
      ),
    );
  }

  void toggleWhichPage() {
    setState(() {
      if (whichPage == ShoppingOrCart.SHOPPING)
        whichPage = ShoppingOrCart.CART;
      else
        whichPage = ShoppingOrCart.SHOPPING;
    });
  }
}
