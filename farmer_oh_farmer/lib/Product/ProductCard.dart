import 'dart:convert';

import 'package:farmer_oh_farmer/Constants.dart';
import 'package:farmer_oh_farmer/Models/ProductList.dart';
import 'package:farmer_oh_farmer/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

enum ShoppingOrCart { SHOPPING, CART }

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductListElement product;
  int productQuantity;
  ShoppingOrCart whichPage;
  Function reloadCart;
  int productIndex;
  Function changeItemQuantityInList;
  ProductCard(this.whichPage, this.product,
      {this.productQuantity = 0,
      this.reloadCart,
      this.productIndex = -1,
      this.changeItemQuantityInList});
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String buttonText;
  bool isAddedToCart = false;
  bool isAddingToCart = false;
  bool isRemovingFromCart = false;

  Widget productPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
      child: Image(
        image: NetworkImage(widget.product.productDataPhotoLink),
        height: 135,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        fit: BoxFit.cover,
      ),
    );
  }

  Widget productNameBuild() {
    return Text(
      widget.product.productDataName,
      style: productCardDarkGreenTextBold,
    );
  }

  Widget productRate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.measurement,
          style: productCardGreenTextBold,
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "₹ " + widget.product.cost.toString(),
              style: productCardCostGreenTextBold,
            ),
            SizedBox(width: 5),
          ],
        ),
      ],
    );
  }

  Widget productQuantity() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Quantity",
          style: productCardGreenTextBold,
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            InkWell(
              onTap: () => decrementProductQuantity(),
              child: Container(
                child: Image(
                  image: AssetImage("assets/minus_button.png"),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(border: Border.all(color: greyBorder)),
              width: 30,
              height: 27,
              child: Text(
                widget.productQuantity.toString(),
                style: TextStyle(
                    fontSize: 17,
                    color: customThemeGreen[900],
                    fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () => incrementProductQuantity(),
              child: Container(
                child: Image(
                  image: AssetImage("assets/plus_button.png"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget productAddToCart() {
    buttonText = "Add To Cart";
    return RaisedButton(
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))),
      onPressed: isAddedToCart ? null : () => addProductToCart(),
      color: customThemeGreen[900],
      child: Container(
        alignment: Alignment.center,
        child: isAddingToCart
            ? Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              )
            : Text(buttonText, style: productAddButton), //add loading
      ),
    );
  }

  Widget productRemoveFromCart() {
    buttonText = "Remove From Cart";

    return RaisedButton(
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))),
      onPressed: () => removeProduct(),
      color: customThemeGreen[900],
      child: Container(
        alignment: Alignment.center,
        child: isRemovingFromCart
            ? Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              )
            : Text(buttonText, style: productAddButton), //add loading
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 130,
            width: 400,
            decoration: BoxDecoration(
              color: customThemeWhite[900],
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            margin: EdgeInsets.only(left: 5, right: 5, top: 7, bottom: 7),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: productPhoto(),
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 7),
                            productNameBuild(),
                            SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                productRate(),
                                SizedBox(width: 20),
                                productQuantity(),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child:
                                  (widget.whichPage == ShoppingOrCart.SHOPPING)
                                      ? productAddToCart()
                                      : productRemoveFromCart(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void incrementProductQuantity() async{
    enableAddToCartButton();
    if (widget.whichPage == ShoppingOrCart.CART) {
      await addProduct();
    }
    setState(() {
      widget.productQuantity++;
      if (widget.whichPage == ShoppingOrCart.CART) widget.changeItemQuantityInList(1, widget.productIndex);
    });
  }

  void decrementProductQuantity() async {
    //print("Pressed Minus")
    if (widget.whichPage == ShoppingOrCart.CART) {
      if (widget.productQuantity == 1) {
        await removeProduct();
      } else {
        await addProduct();
      }
    }
    setState(() {
      if (widget.productQuantity > 0) {
        widget.productQuantity--;
        if (widget.whichPage == ShoppingOrCart.CART) widget.changeItemQuantityInList(-1,widget.productIndex);
      }
    });
     enableAddToCartButton();
  }

  void addProductToCart() {
    if (widget.productQuantity > 0) {
      addProduct();
    }
  }

  Future<void> addProduct() async {
    setState(() {
      isAddingToCart = true;
      isRemovingFromCart = true;
    });
    try {
      final customerInfo = new FlutterSecureStorage();
      String customerId = await customerInfo.read(key: "CustomerId");
      var response = await http.post(Uri.encodeFull(addProductToCartApi),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "customerId": customerId,
            "productId": widget.product.id,
            "productQuantity": widget.productQuantity
          }));
      dynamic result = json.decode(response.body);
      if (result["status"] == SUCCESSFLAG) {
        Toast.show(widget.product.productDataName + " Added To Cart", context,
            duration: Toast.LENGTH_LONG);
        setState(() {
          disableAddToCartButton();
        });
      } else if (result["status"] == FAILEDFLAG) {
        Toast.show(result["message"], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        setState(() {
          isAddingToCart = false;
          isRemovingFromCart = false;
        });
      }
    } catch (e) {
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(() {
        isAddingToCart = false;
        isRemovingFromCart = false;
      });
    }
    setState(() {
      isAddingToCart = false;
      isRemovingFromCart = false;
    });
  }

  Future<void> removeProduct() async {
    setState(() {
      isRemovingFromCart = true;
    });
    try {
      final customerInfo = new FlutterSecureStorage();
      String customerId = await customerInfo.read(key: "CustomerId");
      var response = await http.post(Uri.encodeFull(addProductToCartApi),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "customerId": customerId,
            "productId": widget.product.id,
            "productQuantity": "0"
          }));
      dynamic result = json.decode(response.body);
      if (result["status"] == SUCCESSFLAG) {
        Toast.show(
            widget.product.productDataName + " Removed From The Cart", context,
            duration: Toast.LENGTH_LONG);
        setState(() {
          //disableAddToCartButton();
          widget.reloadCart(widget.productIndex);
        });
      } else if (result["status"] == FAILEDFLAG) {
        Toast.show(result["message"], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        setState(() {
          isRemovingFromCart = false;
        });
      }
    } catch (e) {
      Toast.show(e.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(() {
        isRemovingFromCart = false;
      });
    }
    setState(() {
      isRemovingFromCart = false;
    });
  }

  void enableAddToCartButton() {
    if (isAddedToCart)
      setState(() {
        isAddedToCart = false;
      });
  }

  void disableAddToCartButton() {
    setState(() {
      isAddedToCart = true;
    });
  }
}
