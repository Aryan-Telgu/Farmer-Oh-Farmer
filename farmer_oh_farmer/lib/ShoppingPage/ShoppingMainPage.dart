import 'package:farmer_oh_farmer/ShoppingPage/FarmerDropDownElement.dart';
import 'package:farmer_oh_farmer/Style.dart';
import "package:flutter/material.dart";

import 'FamerTempList.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  Farmer farmer = farmersList[0];

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 30,
      ),
      Center(
        child: Container(
          decoration: dropDownBoxDecoration,
          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
          child:  DropdownButton(
              value: farmer,
              icon: rTextFieldIcon(Icons.arrow_drop_down),
              underline: Container(
                height: 0, // to remove the underline
              ),
              onChanged: (Farmer newValue) {
                setState(() {
                  farmer = newValue;
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
      ),
    ]);
  }
}
