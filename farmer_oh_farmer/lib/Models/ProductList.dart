class ProductList {
  String status;
  String message;
  List<ProductListElement> productListElements;

  ProductList({String status, String message, List<ProductListElement> productListElements}) {
    this.status = status;
    this.message = message;
    this.productListElements = productListElements;
  }

  ProductList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      productListElements = new List<ProductListElement>();
      json['result'].forEach((v) {
        productListElements.add(new ProductListElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.productListElements != null) {
      data['result'] = this.productListElements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductListElement {
  String createdAt;
  String updatedAt;
  int id;
  double cost;
  String measurement;
  String productDataName;
  String productDataPhotoLink;
  int farmerId;
  int productDataId;

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
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.id = id;
    this.cost = cost;
    this.measurement = measurement;
    this.productDataName = productDataName;
    this.productDataPhotoLink = productDataPhotoLink;
    this.farmerId = farmerId;
    this.productDataId = productDataId;
  }

  ProductListElement.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    cost = json['cost'];
    measurement = json['measurement'];
    productDataName = json['productDataName'];
    productDataPhotoLink = json['productDataPhotoLink'];
    farmerId = json['farmerId'];
    productDataId = json['productDataId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['cost'] = this.cost;
    data['measurement'] = this.measurement;
    data['productDataName'] = this.productDataName;
    data['productDataPhotoLink'] = this.productDataPhotoLink;
    data['farmerId'] = this.farmerId;
    data['productDataId'] = this.productDataId;
    return data;
  }
}