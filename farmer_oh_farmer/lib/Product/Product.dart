class Product {
  int productId;
  String productName;
  String productUrl;
  String productMeasurementUnit;
  double productCostPerUnit;
  int productQuantity;

  Product(
      this.productId,
      this.productName,
      this.productUrl,
      this.productMeasurementUnit,
      this.productCostPerUnit,
      {this.productQuantity=0});

   int get getProductId => productId;

 set setProductId(int productId) => this.productId = productId;

 String get getProductName => productName;

 set setProductName(String productName) => this.productName = productName;

 String get getProductUrl => productUrl;

 set setProductUrl(String productUrl) => this.productUrl = productUrl;

 String get getProductMeasurementUnit => productMeasurementUnit;

 set setProductMeasurementUnit(String productMeasurementUnit) => this.productMeasurementUnit = productMeasurementUnit;

 double get getProductCostPerUnit => productCostPerUnit;

 set setProductCostPerUnit(double productCostPerUnit) => this.productCostPerUnit = productCostPerUnit;

 int get getProductQuantity => productQuantity;

 set setProductQuantity(int productQuantity) => this.productQuantity = productQuantity;
  
}

List productList = [
  Product(101,"Tomato","assets/tomato.png","200 grams",60),
  Product(102,"Potato","assets/potato.png","100 grams",40),
  Product(103,"Banana","assets/banana.png","1/2 dozen",100),
  Product(104,"Spinach","assets/spinach.png","1 bunch",20),
  Product(105,"Onion","assets/onion.png","500 grams",120),
  Product(101,"Tomato","assets/tomato.png","200 grams",60),
  Product(102,"Potato","assets/potato.png","100 grams",40),
  Product(103,"Banana","assets/banana.png","1/2 dozen",100),
  Product(104,"Spinach","assets/spinach.png","1 bunch",20),
  Product(105,"Onion","assets/onion.png","500 grams",120),
];
