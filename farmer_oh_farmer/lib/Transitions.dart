import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Route BouncyNavigation(Object page) {
    return PageRouteBuilder(
      transitionDuration: Duration(seconds: 1),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {

        animation = CurvedAnimation(parent: animation,curve: Curves.elasticInOut);

        return ScaleTransition(
          alignment: Alignment.center,
          scale: animation,
          child: child,
        );
      },
    );
  }