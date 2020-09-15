import 'package:farmer_oh_farmer/Style.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'Product.dart';

enum ShoppingOrCart{
  SHOPPING,
  CART
}

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  Product product;

  ShoppingOrCart whichPage;
  ProductCard(this.product,this.whichPage);
  @override
  _ProductCardState createState() => _ProductCardState(whichPage);
}

class _ProductCardState extends State<ProductCard> {
  ShoppingOrCart whichPage ;
  int quantityCount = 0;
  String buttonText ;
  bool isAddedToCart = false;

  _ProductCardState(this.whichPage);

  Widget productPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
      child: Image(
        image: AssetImage(widget.product.getProductUrl),
        height: 135,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget productNameBuild() {
    return Text(
      widget.product.getProductName,
      style: productCardDarkGreenTextBold,
    );
  }

  Widget productRate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.getProductMeasurementUnit,
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
              "₹ " + widget.product.getProductCostPerUnit.toString(),
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
                quantityCount.toString(),
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
    if(whichPage == ShoppingOrCart.SHOPPING){
      buttonText = "Add To Cart";
    }
    else{
      buttonText = "Remove From Cart";
    }
    return RaisedButton(
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))),
      onPressed: isAddedToCart?   null :() => addProductToCart(),
      color: customThemeGreen[900],
      child: Container(
        alignment: Alignment.center,
        child: Text(buttonText, style: productAddButton),
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
                              child: productAddToCart(),
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

  void incrementProductQuantity() {
    //print("Pressed Add");
    enableAddToCartButton();
    setState(() {
      quantityCount++;
    });
  }

  void decrementProductQuantity() {
    //print("Pressed Minus");
    enableAddToCartButton();
    setState(() {
      if (quantityCount > 0) quantityCount--;
    });
  }

  void addProductToCart() {
    print("Pressed Add To Cart");
    if (quantityCount > 0) {
      Toast.show(widget.product.getProductName + " Added To Cart" , context,
          duration: Toast.LENGTH_LONG);
      setState(() {
        disableAddToCartButton();
      });
    }
  }

  void enableAddToCartButton() {
    if(isAddedToCart)
      setState(() {
        isAddedToCart = false;
      });
  }

  void disableAddToCartButton(){
    setState(() {
      isAddedToCart = true;
    });
  }
}
