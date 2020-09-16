import 'package:farmer_oh_farmer/Product/Product.dart';
import 'package:farmer_oh_farmer/Product/ProductCard.dart';
import 'package:farmer_oh_farmer/ShoppingPage/Farmer/FamerTempList.dart';
import 'package:farmer_oh_farmer/Style.dart';
import "package:flutter/material.dart";

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Farmer farmer = farmersList[0];
  bool isCartFilled = false;
  bool isLoading = false;

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

  Widget proceedButton() {
    String buttonText = "Proceed To CheckOut";
    return RaisedButton(
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      onPressed: null,
      disabledColor: customThemeGreen[900],
      color: customThemeGreen[900],
      child: Container(
        alignment: Alignment.center,
        child: Text(buttonText, style: proceedCheckOutButton),
      ),
    );
  }

  Widget cartIsEmpty() {
    return Image(image: AssetImage("assets/cart_is_empty.png"));
  }

  Widget cartIsFilled() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: productList.length,
            shrinkWrap: false,
            itemBuilder: (BuildContext context, index) {
              return ProductCard(productList[index], ShoppingOrCart.CART);
            },
          ),
        ),
        Container(padding: EdgeInsets.all(20), child: proceedButton()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              isCartFilled ? cartIsFilled() : cartIsEmpty(),
            ],
          ),
        ),
      ],
    );
  }
}