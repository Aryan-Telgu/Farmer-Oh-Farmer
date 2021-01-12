import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Customer {
  String status;
  String message;
  Result result;

  Customer({String status, String message, Result result}) {
    this.status = status;
    this.message = message;
    this.result = result;
  }

  Customer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String createdAt;
  String updatedAt;
  int id;
  String name;
  String phone;
  String email;
  String address;
  int pincode;

  Result(
      {String createdAt,
      String updatedAt,
      int id,
      String name,
      String phone,
      String email,
      String address,
      int pincode}) {
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.id = id;
    this.name = name;
    this.phone = phone;
    this.email = email;
    this.address = address;
    this.pincode = pincode;
  }

  Result.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    return data;
  }

  Future<void> saveCustomerDataLocally() async {
    final customerInfo = new FlutterSecureStorage();
    await customerInfo.write(key: "CustomerId", value: this.id.toString());
    await customerInfo.write(key: "CustomerName", value: this.name);
    await customerInfo.write(key: "CustomerPhone", value: this.phone);
    await customerInfo.write(key: "CustomerEmail", value: this.email);
    await customerInfo.write(key: "CustomerAddress", value: this.address);
    await customerInfo.write(key: "CustomerPincode", value: this.pincode.toString());
    print("LogedIn");
  }

  Future<void> deleteCustomerDataLocally() async {
    final customerInfo = new FlutterSecureStorage();
    await customerInfo.deleteAll();
    print("Loged Out");
  }
}

