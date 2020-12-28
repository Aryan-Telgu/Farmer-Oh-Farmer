import 'dart:convert';

import 'package:farmer_oh_farmer/Constants.dart';
import 'package:farmer_oh_farmer/Models/FarmerList.dart';
import 'package:farmer_oh_farmer/Models/ProductList.dart';
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
  List<ProductListElement> productListElements = new List<ProductListElement>();
  bool isServiceAvailable = true;
  bool isFarmerSelected = false;
  bool isProductAvailable = true;
  bool areFarmersLoading = false;
  bool areProductsLoading = false;

  @override
  void initState() {
    super.initState();
    searchFarmerByLocation();
  }

  Future<String> searchFarmerByLocation() async {
    setState(() {
      areFarmersLoading = true;
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
          areFarmersLoading = false;
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
        areFarmersLoading = false;
      });
    }
    setState(() {
      areFarmersLoading = false;
    });
  }

  Future<String> getProductFromFarmer(FarmerListElement selectedFarmer) async {
    setState(() {
      isProductAvailable = true;
      areProductsLoading = true;
    });
    try {
      var response = await http.post(Uri.encodeFull(getProductsFromFarmerApi),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"farmerId": selectedFarmer.farmerId}));
      ProductList productList = ProductList.fromJson(json.decode(response.body));
      if (productList.status == SUCCESSFLAG) {
        setState(() {
          areProductsLoading = false;
          isProductAvailable = true;
          productListElements = productList.productListElements;
        });
      } else if (productList.status == FAILEDFLAG) {
        setState(() {
          areProductsLoading = false;
          isProductAvailable = false;
          productListElements.clear();
        });
        
        Toast.show(productList.message, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(() {
        areProductsLoading = false;
      });
    }
    setState(() {
      areProductsLoading = false;
    });
  }

  Widget farmerDropDown() {
    return Center(
      child: Container(
        decoration: dropDownBoxDecoration,
        padding: areFarmersLoading ? EdgeInsets.all(10):EdgeInsets.fromLTRB(10, 10, 0, 10),
        child: areFarmersLoading ? loadingSymbol():DropdownButton(
          value: farmer,
          icon: rTextFieldIcon(Icons.arrow_drop_down),
          underline: Container(
            height: 0, // to remove the underline
          ),
          onChanged: (FarmerListElement newValue) {
            setState(() {
              farmer = newValue;
              if (farmerListElements.indexOf(farmer) != 0) {
                getProductFromFarmer(farmer);
                isFarmerSelected = true;
                areProductsLoading = true;
              } else
                isFarmerSelected = false;
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

  Widget errorImage(bool isServiceAvailable , bool isFarmerSelected , bool isProductAvailable){
    if(!isServiceAvailable)
      return Image(image: AssetImage("assets/service_not_available.png"));
    if(!isProductAvailable)
      return Image(image: AssetImage("assets/products_not_available.png"));
    if(!isFarmerSelected)
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
            if(!isServiceAvailable || !isProductAvailable || !isFarmerSelected)
            errorImage(isServiceAvailable,isFarmerSelected,isProductAvailable),
            if (areProductsLoading) loadingSymbol(),//not able to see loading symbol
            if (isFarmerSelected && !areProductsLoading && isProductAvailable)
              ListView.builder(
                itemCount: productListElements.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return ProductCard(
                      productListElements[index], ShoppingOrCart.SHOPPING);
                },
              ),
          ],
        ),
      )
    ]);
  }
}
