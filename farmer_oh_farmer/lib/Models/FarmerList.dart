class FarmerList {
  String _status;
  String _message;
  List<Result> _result;

  FarmerList({String status, String message, List<Result> result}) {
    this._status = status;
    this._message = message;
    this._result = result;
  }

  String get status => _status;
  set status(String status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  List<Result> get result => _result;
  set result(List<Result> result) => _result = result;

  FarmerList.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = new List<Result>();
      json['result'].forEach((v) {
        _result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String _farmerName;
  int _farmerId;
  double _farmerRating;

  Result({String farmerName, int farmerId, double farmerRating}) {
    this._farmerName = farmerName;
    this._farmerId = farmerId;
    this._farmerRating = farmerRating;
  }

  String get farmerName => _farmerName;
  set farmerName(String farmerName) => _farmerName = farmerName;
  int get farmerId => _farmerId;
  set farmerId(int farmerId) => _farmerId = farmerId;
  double get farmerRating => _farmerRating;
  set farmerRating(double farmerRating) => _farmerRating = farmerRating;

  Result.fromJson(Map<String, dynamic> json) {
    _farmerName = json['farmerName'];
    _farmerId = json['farmerId'];
    _farmerRating = json['farmerRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farmerName'] = this._farmerName;
    data['farmerId'] = this._farmerId;
    data['farmerRating'] = this._farmerRating;
    return data;
  }
}