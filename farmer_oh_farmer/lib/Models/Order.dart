class Order {
  String _status;
  String _message;
  OrderDetails _orderDetails;

  Order({String status, String message, OrderDetails orderDetails}) {
    this._status = status;
    this._message = message;
    this._orderDetails = orderDetails;
  }

  String get status => _status;
  set status(String status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  OrderDetails get orderDetails => _orderDetails;
  set result(OrderDetails orderDetails) => _orderDetails = orderDetails;

  Order.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _orderDetails =
        json['result'] != null ? new OrderDetails.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._orderDetails != null) {
      data['result'] = this._orderDetails.toJson();
    }
    return data;
  }
}

class OrderDetails {
  String _createdAt;
  String _updatedAt;
  int _id;
  String _deliveryStatus;
  int _farmerId;
  int _customerId;
  int _courierId;

  OrderDetails(
      {String createdAt,
      String updatedAt,
      int id,
      String deliveryStatus,
      int farmerId,
      int customerId,
      int courierId}) {
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._id = id;
    this._deliveryStatus = deliveryStatus;
    this._farmerId = farmerId;
    this._customerId = customerId;
    this._courierId = courierId;
  }

  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  int get id => _id;
  set id(int id) => _id = id;
  String get deliveryStatus => _deliveryStatus;
  set deliveryStatus(String deliveryStatus) => _deliveryStatus = deliveryStatus;
  int get farmerId => _farmerId;
  set farmerId(int farmerId) => _farmerId = farmerId;
  int get customerId => _customerId;
  set customerId(int customerId) => _customerId = customerId;
  int get courierId => _courierId;
  set courierId(int courierId) => _courierId = courierId;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _id = json['id'];
    _deliveryStatus = json['deliveryStatus'];
    _farmerId = json['farmerId'];
    _customerId = json['customerId'];
    _courierId = json['courierId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    data['id'] = this._id;
    data['deliveryStatus'] = this._deliveryStatus;
    data['farmerId'] = this._farmerId;
    data['customerId'] = this._customerId;
    data['courierId'] = this._courierId;
    return data;
  }
}