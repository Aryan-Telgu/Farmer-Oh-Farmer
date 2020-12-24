import 'dart:convert';

import 'package:farmer_oh_farmer/Constants.dart';
import 'package:farmer_oh_farmer/Models/FarmerList.dart';
import 'package:farmer_oh_farmer/Product/Product.dart';
import 'package:farmer_oh_farmer/ShoppingPage/Farmer/FarmerDropDownElement.dart';
import 'package:farmer_oh_farmer/Product/ProductCard.dart';
import 'package:farmer_oh_farmer/Style.dart';
import 'package:farmer_oh_farmer/Transitions.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'Farmer/FamerTempList.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  Farmer farmer  = farmersList[0];
  bool isFarmerSelected = false;
  bool isLoading = false;

  Future<String> loginCustomer() async {
    setState(() {
      isLoading = true;
    });
    try {
      final customerInfo = new FlutterSecureStorage();
      String customerPincode = await customerInfo.read(key: "CustomerPincode");
      var response = await http.post(Uri.encodeFull(loginApi),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"pincode": customerPincode}));
      FarmerList farmerList = FarmerList.fromJson(json.decode(response.body));
      if (farmerList.status == SUCCESSFLAG) {

        setState(() {
          isLoading = false;
        });
        
      } else if (farmerList.status == FAILEDFLAG) {
        Toast.show(farmerList.message, context,
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
              isLoading = false; // remove this when data retrival code is ready
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
    return Image(image: AssetImage("assets/select_farmer.png"));
  }

  Widget loadingSymbol() {
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 20,
      ),
      farmerDropDown(),
      SizedBox(height: 10),
      Expanded(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!isFarmerSelected) selectFarmerImage(),
            if (isLoading) loadingSymbol(),
            if (isFarmerSelected && !isLoading)
              ListView.builder(
                itemCount: productList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return ProductCard(
                      productList[index], ShoppingOrCart.SHOPPING);
                },
              ),
          ],
        ),
      )
    ]);
  }
}
