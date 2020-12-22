import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Customer {
  String _status;
  String _message;
  Result _result;

  Customer({String status, String message, Result result}) {
    this._status = status;
    this._message = message;
    this._result = result;
  }

  String get status => _status;
  set status(String status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  Result get result => _result;
  set result(Result result) => _result = result;

  Customer.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._result != null) {
      data['result'] = this._result.toJson();
    }
    return data;
  }
}

class Result {
  String _createdAt;
  String _updatedAt;
  int _id;
  String _name;
  String _phone;
  String _email;
  String _address;
  int _pincode;

  Result(
      {String createdAt,
      String updatedAt,
      int id,
      String name,
      String phone,
      String email,
      String address,
      int pincode}) {
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._id = id;
    this._name = name;
    this._phone = phone;
    this._email = email;
    this._address = address;
    this._pincode = pincode;
  }

  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;
  String get email => _email;
  set email(String email) => _email = email;
  String get address => _address;
  set address(String address) => _address = address;
  int get pincode => _pincode;
  set pincode(int pincode) => _pincode = pincode;

  Result.fromJson(Map<String, dynamic> json) {
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _address = json['address'];
    _pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    data['id'] = this._id;
    data['name'] = this._name;
    data['phone'] = this._phone;
    data['email'] = this._email;
    data['address'] = this._address;
    data['pincode'] = this._pincode;
    return data;
  }

  Future<void> saveCustomerDataLocally() async {
    final customerInfo = new FlutterSecureStorage();
    await customerInfo.write(key: "CustomerId", value: this._id.toString());
    await customerInfo.write(key: "CustomerName", value: this._name);
    await customerInfo.write(key: "CustomerPhone", value: this._phone);
    await customerInfo.write(key: "CustomerEmail", value: this._email);
    await customerInfo.write(key: "CustomerAddress", value: this._address);
    await customerInfo.write(key: "CustomerPincode", value: this.pincode.toString());
    print("LogedIn");
  }

  Future<void> deleteCustomerDataLocally() async {
    final customerInfo = new FlutterSecureStorage();
    await customerInfo.deleteAll();
    print("Loged Out");
  }
}

