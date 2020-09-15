import 'package:farmer_oh_farmer/Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

// ignore: must_be_immutable
class FarmerDropDownElement extends StatelessWidget {
  FarmerDropDownElement(this.name, this.rating);
  String name;
  double rating;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: farmerDropDownBoxElementDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              width: 130,
              child: Text(
                name,
                style: whiteTextBold,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            StarRating(
              size: 25.0,
              rating: rating,
              color: themeColorWhite[800],
              borderColor: themeColorWhite[800],
              starCount: 5,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
