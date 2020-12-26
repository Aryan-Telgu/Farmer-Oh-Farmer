import 'dart:convert';

import 'package:farmer_oh_farmer/Constants.dart';
import 'package:farmer_oh_farmer/Models/FarmerList.dart';
import 'package:farmer_oh_farmer/Product/Product.dart';
import 'package:farmer_oh_farmer/ShoppingPage/Farmer/FarmerDropDownElement.dart';
import 'package:farmer_oh_farmer/Product/ProductCard.dart';
import 'package:farmer_oh_farmer/Style.dart';
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
  List<FarmerListElement> farmerListElements = new List<FarmerListElement>();
  FarmerListElement farmer = new FarmerListElement(farmerName: "Select Farmer",farmerRating: 0.0);
  bool isServiceAvailable = true;
  bool isFarmerSelected = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    searchFarmerByLocation();
  }

  Future<String> searchFarmerByLocation() async {
    setState(() {
      isLoading = true;
    });
    try {
      final customerInfo = new FlutterSecureStorage();
      String customerPincode = await customerInfo.read(key: "CustomerPincode");
      var response = await http.post(Uri.encodeFull(searchFarmerByLocationApi),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"pincode": customerPincode}));
      FarmerList farmerList = FarmerList.fromJson(json.decode(response.body));
      if (farmerList.status == SUCCESSFLAG) {
        setState(() {
          isLoading = false;
          farmerList.farmerListElements.insert(0, farmer);
          this.farmerListElements = farmerList.farmerListElements;
          farmer = farmerList.farmerListElements[0];
        });
      } else if (farmerList.status == FAILEDFLAG) {
        farmerList.farmerListElements = new List<FarmerListElement>();
        farmerList.farmerListElements.insert(0, farmer);
        this.farmerListElements = farmerList.farmerListElements;
        farmer = farmerList.farmerListElements[0];
        setState(() {
          isServiceAvailable = false;
        });
        isServiceAvailable = false;
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
        child: isLoading ? loadingSymbol():DropdownButton(
          value: farmer,
          icon: rTextFieldIcon(Icons.arrow_drop_down),
          underline: Container(
            height: 0, // to remove the underline
          ),
          onChanged: (FarmerListElement newValue) {
            setState(() {
              farmer = newValue;
              if (farmerListElements.indexOf(farmer) != 0) {
                isFarmerSelected = true;
                isLoading = true;
              } else
                isFarmerSelected = false;
              isLoading = false; // remove this when data retrival code is ready
            });
          },
          items: farmerListElements.map<DropdownMenuItem<FarmerListElement>>((FarmerListElement value) {
            return DropdownMenuItem<FarmerListElement>(
              value: value,
              child: FarmerDropDownElement(value.farmerName, value.farmerRating),
            );
          }).toList(),
          dropdownColor: customThemeWhite[900],
        ),
      ),
    );
  }

  Widget errorImage(bool isServiceAvailable , bool isFarmerSelected){
    if(!isFarmerSelected && !isServiceAvailable)
      return Image(image: AssetImage("assets/service_not_available.png"));
    else
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
            if (!isFarmerSelected) errorImage(isServiceAvailable,isFarmerSelected),
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
