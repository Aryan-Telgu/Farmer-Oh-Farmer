import 'package:farmer_oh_farmer/Models/ProductList.dart';

class CartProductList {
  String status;
  String message;
  List<CartListElement> cartListElements;

  CartProductList({String status, String message, List<CartListElement> cartListElements}) {
    this.status = status;
    this.message = message;
    this.cartListElements = cartListElements;
  }

  CartProductList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      cartListElements = new List<CartListElement>();
      json['result'].forEach((v) {
        cartListElements.add(new CartListElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cartListElements != null) {
      data['result'] = this.cartListElements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartListElement {
  int id;
  int productQuantity;
  ProductListElement productListElement;
  String isOrdered;

  CartListElement({int id, int productQuantity, ProductListElement productListElement, String isOrdered}) {
    this.id = id;
    this.productQuantity = productQuantity;
    this.productListElement = productListElement;
    this.isOrdered = isOrdered;
  }

  CartListElement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productQuantity = json['productQuantity'];
    productListElement =
        json['product'] != null ? new ProductListElement.fromJson(json['product']) : null;
    isOrdered = json['isOrdered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productQuantity'] = this.productQuantity;
    if (this.productListElement != null) {
      data['product'] = this.productListElement.toJson();
    }
    data['isOrdered'] = this.isOrdered;
    return data;
  }
}