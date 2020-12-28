class ProductList {
  String _status;
  String _message;
  List<ProductListElement> _productListElements;

  ProductList({String status, String message, List<ProductListElement> productListElements}) {
    this._status = status;
    this._message = message;
    this._productListElements = productListElements;
  }

  String get status => _status;
  set status(String status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  List<ProductListElement> get productListElements => _productListElements;
  set productListElements(List<ProductListElement> productListElements) => _productListElements = productListElements;

  ProductList.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _productListElements = new List<ProductListElement>();
      json['result'].forEach((v) {
        _productListElements.add(new ProductListElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._productListElements != null) {
      data['result'] = this._productListElements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductListElement {
  String _createdAt;
  String _updatedAt;
  int _id;
  double _cost;
  String _measurement;
  String _productDataName;
  String _productDataPhotoLink;
  int _farmerId;
  int _productDataId;

  ProductListElement(
      {String createdAt,
      String updatedAt,
      int id,
      double cost,
      String measurement,
      String productDataName,
      String productDataPhotoLink,
      int farmerId,
      int productDataId}) {
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._id = id;
    this._cost = cost;
    this._measurement = measurement;
    this._productDataName = productDataName;
    this._productDataPhotoLink = productDataPhotoLink;
    this._farmerId = farmerId;
    this._productDataId = productDataId;
  }

  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  int get id => _id;
  set id(int id) => _id = id;
  double get cost => _cost;
  set cost(double cost) => _cost = cost;
  String get measurement => _measurement;
  set measurement(String measurement) => _measurement = measurement;
  String get productDataName => _productDataName;
  set productDataName(String productDataName) =>
      _productDataName = productDataName;
  String get productDataPhotoLink => _productDataPhotoLink;
  set productDataPhotoLink(String productDataPhotoLink) =>
      _productDataPhotoLink = productDataPhotoLink;
  int get farmerId => _farmerId;
  set farmerId(int farmerId) => _farmerId = farmerId;
  int get productDataId => _productDataId;
  set productDataId(int productDataId) => _productDataId = productDataId;

  ProductListElement.fromJson(Map<String, dynamic> json) {
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _id = json['id'];
    _cost = json['cost'];
    _measurement = json['measurement'];
    _productDataName = json['productDataName'];
    _productDataPhotoLink = json['productDataPhotoLink'];
    _farmerId = json['farmerId'];
    _productDataId = json['productDataId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    data['id'] = this._id;
    data['cost'] = this._cost;
    data['measurement'] = this._measurement;
    data['productDataName'] = this._productDataName;
    data['productDataPhotoLink'] = this._productDataPhotoLink;
    data['farmerId'] = this._farmerId;
    data['productDataId'] = this._productDataId;
    return data;
  }
}