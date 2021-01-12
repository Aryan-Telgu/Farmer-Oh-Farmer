class Order {
  String status;
  String message;
  OrderDetails orderDetails;

  Order({String status, String message, OrderDetails orderDetails}) {
    this.status = status;
    this.message = message;
    this.orderDetails = orderDetails;
  }

  Order.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderDetails =
        json['result'] != null ? new OrderDetails.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.orderDetails != null) {
      data['result'] = this.orderDetails.toJson();
    }
    return data;
  }
}

class OrderDetails {
  String createdAt;
  String updatedAt;
  int id;
  String deliveryStatus;
  String farmerName;
  int customerId;
  int courierId;

  OrderDetails(
      {String createdAt,
      String updatedAt,
      int id,
      String deliveryStatus,
      String farmerName,
      int customerId,
      int courierId}) {
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.id = id;
    this.deliveryStatus = deliveryStatus;
    this.farmerName = farmerName;
    this.customerId = customerId;
    this.courierId = courierId;
  }

  OrderDetails.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    deliveryStatus = json['deliveryStatus'];
    farmerName = json['farmerName'];
    customerId = json['customerId'];
    courierId = json['courierId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['deliveryStatus'] = this.deliveryStatus;
    data['farmerName'] = this.farmerName;
    data['customerId'] = this.customerId;
    data['courierId'] = this.courierId;
    return data;
  }
}