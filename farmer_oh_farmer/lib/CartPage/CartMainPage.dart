import 'dart:convert';

import 'package:farmer_oh_farmer/Constants.dart';
import 'package:farmer_oh_farmer/Models/CartProductList.dart';
import 'package:farmer_oh_farmer/Models/Order.dart';
import 'package:farmer_oh_farmer/Models/ProductList.dart';
import 'package:farmer_oh_farmer/Product/Product.dart';
import 'package:farmer_oh_farmer/Product/ProductCard.dart';
import 'package:farmer_oh_farmer/ShoppingPage/Farmer/FamerTempList.dart';
import 'package:farmer_oh_farmer/Style.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Farmer farmer = farmersList[0];
  bool isCartEmpty = true;
  bool isLoading = true;
  bool isPlacingOrder = false;
  List<CartListElement> cartListElements = new List();
  String customerId;
  double totalCost = 0;

  @override
  void initState() {
    super.initState();
    getCartProducts();
  }

  Future<String> getCartProducts() async {
    setState(() {
      isLoading = true;
      cartListElements.clear();
    });
    try {
      final customerInfo = new FlutterSecureStorage();
      customerId = await customerInfo.read(key: "CustomerId");
      var response = await http.post(Uri.encodeFull(getCartProductsApi),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"customerId": customerId}));
      CartProductList cartProductList =
          CartProductList.fromJson(json.decode(response.body));
      if (cartProductList.status == SUCCESSFLAG) {
        setState(() {
          isCartEmpty = false;
          isLoading = false;
          cartListElements = cartProductList.cartListElements;
          calculateTotalCost();
        });
      } else if (cartProductList.status == FAILEDFLAG) {
        setState(() {
          isCartEmpty = true;
          isLoading = false;
          cartListElements.clear();
        });

        Toast.show(cartProductList.message, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(() {
        //do something
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
      //do something
    });
  }

  void removeProductFromcartListElements(int productToRemoveIndex) {
    setState(() {
      cartListElements.removeAt(productToRemoveIndex);
      calculateTotalCost();
      if (cartListElements.isEmpty) isCartEmpty = true;
    });
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

  Widget proceedButton() {
    String buttonText = "Proceed To CheckOut";
    return RaisedButton(
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      onPressed: isPlacingOrder ? null : placeOrder,
      color: customThemeGreen[900],
      child: Container(
        alignment: Alignment.center,
        child: isPlacingOrder
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(buttonText, style: proceedCheckOutButton),
      ),
    );
  }

  Future<String> placeOrder() async {
    setState(() {
      isPlacingOrder = true;
    });
    try {
      var response = await http.post(Uri.encodeFull(placeOrderApi),
          headers: {"Content-Type": "application/json"},
          body: json
              .encode({"customerId": customerId, "orderAmount": totalCost}));
      Order order = Order.fromJson(json.decode(response.body));
      if (order.status == SUCCESSFLAG) {
        setState(() {
          isPlacingOrder = false;
          print("success");
          cartListElements.clear();
          getCartProducts();
          //Do Something
        });
      } else if (order.status == FAILEDFLAG) {
        setState(() {
          isPlacingOrder = false;
          //Do Something
        });

        Toast.show(order.message, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } catch (e) {
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(() {
        //do something
        isPlacingOrder = false;
      });
    }
    setState(() {
      isPlacingOrder = false;
      //do something
    });
  }

  Widget cartIsEmpty() {
    return Center(child: Image(image: AssetImage("assets/cart_is_empty.png")));
  }

  Widget cartIsFilled() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 7, bottom: 7),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 60,
          width: 400,
          decoration: BoxDecoration(
            color: customThemeGreen[900],
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total :", style: totalCostStyle),
              Text("₹ " + totalCost.toString(), style: totalCostStyle)
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cartListElements.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              return ProductCard(
                ShoppingOrCart.CART,
                cartListElements[index].productListElement,
                productQuantity: cartListElements[index].productQuantity,
                reloadCart: removeProductFromcartListElements,
                productIndex: index,
                changeItemQuantityInList: changeItemQuantityInList,
              );
            },
          ),
        ),
        Container(padding: EdgeInsets.all(20), child: proceedButton()),
      ],
    );
  }

  void changeItemQuantityInList(int quantity, int index) {
    cartListElements[index].productQuantity += quantity;
    calculateTotalCost();
  }

  void calculateTotalCost() {
    double cost = 0;
    for (CartListElement cartListElement in cartListElements) {
      cost += cartListElement.productQuantity *
          cartListElement.productListElement.cost;
    }
    setState(() {
      totalCost = cost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                isLoading
                    ? loadingSymbol()
                    : isCartEmpty
                        ? cartIsEmpty()
                        : cartIsFilled(),
              ],
            ),
          ),
        ]);
  }
}
