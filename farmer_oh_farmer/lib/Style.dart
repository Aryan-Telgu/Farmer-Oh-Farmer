import 'package:flutter/material.dart';

//Color Themes Go Here

Map<int, Color> themeColorGreen = {
  50: Color.fromRGBO(108, 142, 10, .1),
  100: Color.fromRGBO(108, 142, 10, .2),
  200: Color.fromRGBO(108, 142, 10, .3),
  300: Color.fromRGBO(108, 142, 10, .4),
  400: Color.fromRGBO(108, 142, 10, .5),
  500: Color.fromRGBO(108, 142, 10, .6),
  600: Color.fromRGBO(108, 142, 10, .7),
  700: Color.fromRGBO(108, 142, 10, .8),
  800: Color.fromRGBO(108, 142, 10, .9),
  900: Color.fromRGBO(108, 142, 10, 1),
};

MaterialColor customThemeGreen = MaterialColor(0xFF6C8E0A, themeColorGreen);

Map<int, Color> themeColorWhite = {
  50: Color.fromRGBO(255, 255, 255, .1),
  100: Color.fromRGBO(255, 255, 255, .2),
  200: Color.fromRGBO(255, 255, 255, .3),
  300: Color.fromRGBO(255, 255, 255, .4),
  400: Color.fromRGBO(255, 255, 255, .5),
  500: Color.fromRGBO(255, 255, 255, .6),
  600: Color.fromRGBO(255, 255, 255, .7),
  700: Color.fromRGBO(255, 255, 255, .8),
  800: Color.fromRGBO(255, 255, 255, .9),
  900: Color.fromRGBO(255, 255, 255, 1),
};

MaterialColor customThemeWhite = MaterialColor(0xFF6C8E0A, themeColorWhite);

Color greyBorder = Color(0x70707000);

//----------------------------------------------------------------------------

// Text Styles Go Here

TextStyle blackText = TextStyle(color: Colors.black);
TextStyle whiteText = TextStyle(color: Colors.white);
TextStyle whiteTextBold =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
TextStyle productCardGreenTextBold = TextStyle(
    color: customThemeGreen[400], fontWeight: FontWeight.bold, fontSize: 15);
TextStyle productCardDarkGreenTextBold = TextStyle(
    color: customThemeGreen[900], fontWeight: FontWeight.bold, fontSize: 17);
TextStyle productCardCostGreenTextBold = TextStyle(
    fontWeight: FontWeight.bold, color: customThemeGreen[800], fontSize: 25);
TextStyle productAddButton = TextStyle(
    fontWeight: FontWeight.bold, color: customThemeWhite[900], fontSize: 15);
TextStyle proceedCheckOutButton = TextStyle(
    fontWeight: FontWeight.bold, color: customThemeWhite[900], fontSize: 20);
TextStyle totalCostStyle = TextStyle(
    fontWeight: FontWeight.bold, color: customThemeWhite[900], fontSize: 25);

//----------------------------------------------------------------------------

Widget rTextFieldIcon(IconData iconData) {
  return Icon(
    iconData,
    color: themeColorGreen[900],
    size: 40,
  );
}

//----------------------------------------------------------------------------

//BoxDecorations

BoxDecoration farmerDropDownBoxElementDecoration = BoxDecoration(
    color: themeColorGreen[600],
    borderRadius: BorderRadius.all(Radius.circular(10)));

BoxDecoration dropDownBoxDecoration = BoxDecoration(
    color: themeColorWhite[900],
    borderRadius: BorderRadius.all(Radius.circular(10)));

//----------------------------------------------------------------------------

//InputDecoration

InputDecoration loginPageInputDecoration(String hintText){
  return InputDecoration(
    filled: true,
    fillColor: Colors.white70,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 22.0, color: Colors.black54),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
        borderSide: BorderSide(width: 1, color: Colors.grey)));
}