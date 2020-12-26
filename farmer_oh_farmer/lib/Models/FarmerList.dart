class FarmerList {
  String _status;
  String _message;
  List<FarmerListElement> _farmerListElements;

  FarmerList({String status, String message, List<FarmerListElement> farmerListElements}) {
    this._status = status;
    this._message = message;
    this._farmerListElements = farmerListElements;
  }

  String get status => _status;
  set status(String status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  List<FarmerListElement> get farmerListElements => _farmerListElements;
  set farmerListElements(List<FarmerListElement> farmerListElements) => _farmerListElements = farmerListElements;

  FarmerList.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _farmerListElements = new List<FarmerListElement>();
      json['result'].forEach((v) {
        _farmerListElements.add(new FarmerListElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._farmerListElements != null) {
      data['result'] = this._farmerListElements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerListElement {
  String _farmerName;
  int _farmerId;
  double _farmerRating;

  FarmerListElement({String farmerName, int farmerId, double farmerRating}) {
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

  FarmerListElement.fromJson(Map<String, dynamic> json) {
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