import 'package:farmer_oh_farmer/ShoppingPage/Farmer/FarmerDropDownElement.dart';
import 'package:farmer_oh_farmer/ShoppingPage/Product/ProductCard.dart';
import 'package:farmer_oh_farmer/Style.dart';
import "package:flutter/material.dart";

import 'Farmer/FamerTempList.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  Farmer farmer = farmersList[0];
  bool isFarmerSelected = true;
  bool isLoading = false;

  Widget farmerDropDown() {
    return Center(
      child: Container(
        decoration: dropDownBoxDecoration,
        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
        child: DropdownButton(
          value: farmer,
          icon: rTextFieldIcon(Icons.arrow_drop_down),
          underline: Container(
            height: 0, // to remove the underline
          ),
          onChanged: (Farmer newValue) {
            setState(() {
              farmer = newValue;
              if (farmersList.indexOf(farmer) != 0) {
                isFarmerSelected = true;
                isLoading = true;
              } else
                isFarmerSelected = false;
            });
          },
          items: farmersList.map<DropdownMenuItem<Farmer>>((Farmer value) {
            return DropdownMenuItem<Farmer>(
              value: value,
              child: FarmerDropDownElement(value.name, value.rating),
            );
          }).toList(),
          dropdownColor: customThemeWhite[900],
        ),
      ),
    );
  }

  Widget selectFarmerImage() {
    return Column(
      children: [
        SizedBox(
          height: 200,
        ),
        Image(image: AssetImage("assets/select_farmer.png")),
      ],
    );
  }

  Widget loadingSymbol() {
    return Column(
      children: [
        SizedBox(
          height: 250,
        ),
        CircularProgressIndicator(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 30,
      ),
      farmerDropDown(),
      if (!isFarmerSelected) selectFarmerImage(),
      if (isLoading) loadingSymbol(),
      ProductCard(),
    ]);
  }
}
