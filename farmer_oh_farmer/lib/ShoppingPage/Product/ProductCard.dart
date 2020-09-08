import 'package:farmer_oh_farmer/Style.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String measurementUnit = "200 grams";
  String costPerUnit = "60";
  int quantityCount = 0;

  Widget productPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      child: Image(
        image: AssetImage("assets/tomato.png"),
        height: 130,
        width: 120,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget productRate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          measurementUnit,
          style: productCardGreenTextBold,
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("₹ "+costPerUnit, style: productCardCostGreenTextBold,),
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
            Container(
              child: Image(
                image: AssetImage("assets/minus_button.png"),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(border: Border.all(color: Color(0x70707000))),
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
            Container(
              child: Image(
                image: AssetImage("assets/plus_button.png"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget productAddToCart() {
    return Container(
      height: 35,
      decoration: BoxDecoration(
          color: customThemeGreen[900],
          borderRadius: BorderRadius.only(bottomRight: Radius.circular((20)))),
      alignment: Alignment.center,
      child: Text("Add To Cart",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: customThemeWhite[900])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 130,
          width: 400,
          decoration: BoxDecoration(
            color: customThemeWhite[900],
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          margin: EdgeInsets.all(15),
          child: Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: productPhoto(),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
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
        ),
      ],
    );
  }
}
