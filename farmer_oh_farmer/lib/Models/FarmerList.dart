class FarmerList {
  String status;
  String message;
  List<FarmerListElement> farmerListElements;

  FarmerList({String status, String message, List<FarmerListElement> farmerListElements}) {
    this.status = status;
    this.message = message;
    this.farmerListElements = farmerListElements;
  }

  FarmerList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      farmerListElements = new List<FarmerListElement>();
      json['result'].forEach((v) {
        farmerListElements.add(new FarmerListElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.farmerListElements != null) {
      data['result'] = this.farmerListElements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerListElement {
  String farmerName;
  int farmerId;
  double farmerRating;

  FarmerListElement({String farmerName, int farmerId, double farmerRating}) {
    this.farmerName = farmerName;
    this.farmerId = farmerId;
    this.farmerRating = farmerRating;
  }

  FarmerListElement.fromJson(Map<String, dynamic> json) {
    farmerName = json['farmerName'];
    farmerId = json['farmerId'];
    farmerRating = json['farmerRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farmerName'] = this.farmerName;
    data['farmerId'] = this.farmerId;
    data['farmerRating'] = this.farmerRating;
    return data;
  }
}