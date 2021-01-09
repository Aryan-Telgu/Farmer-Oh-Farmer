import 'package:farmer_oh_farmer/Models/ProductList.dart';

class CartProductList {
  String _status;
  String _message;
  List<CartListElement> _cartListElements;

  CartProductList({String status, String message, List<CartListElement> cartListElements}) {
    this._status = status;
    this._message = message;
    this._cartListElements = cartListElements;
  }

  String get status => _status;
  set status(String status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  List<CartListElement> get cartListElements => _cartListElements;
  set cartListElements(List<CartListElement> cartListElements) => _cartListElements = cartListElements;

  CartProductList.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _cartListElements = new List<CartListElement>();
      json['result'].forEach((v) {
        _cartListElements.add(new CartListElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._cartListElements != null) {
      data['result'] = this._cartListElements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartListElement {
  int _id;
  int _productQuantity;
  ProductListElement _productListElement;
  String _isOrdered;

  CartListElement({int id, int productQuantity, ProductListElement productListElement, String isOrdered}) {
    this._id = id;
    this._productQuantity = productQuantity;
    this._productListElement = productListElement;
    this._isOrdered = isOrdered;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get productQuantity => _productQuantity;
  set productQuantity(int productQuantity) =>
      _productQuantity = productQuantity;
  ProductListElement get productListElement => _productListElement;
  set productListElement(ProductListElement productListElement) => _productListElement = productListElement;
  String get isOrdered => _isOrdered;
  set isOrdered(String isOrdered) => _isOrdered = isOrdered;

  CartListElement.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productQuantity = json['productQuantity'];
    _productListElement =
        json['product'] != null ? new ProductListElement.fromJson(json['product']) : null;
    _isOrdered = json['isOrdered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['productQuantity'] = this._productQuantity;
    if (this._productListElement != null) {
      data['product'] = this._productListElement.toJson();
    }
    data['isOrdered'] = this._isOrdered;
    return data;
  }
}