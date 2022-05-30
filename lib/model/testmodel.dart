class TestModel {
  int? formulirId; // : 0,
  String? formulirNumber; //: “String”
  DateTime? createdDate; //: "2022-04-25T06:28:26.664Z"
  int? customerId; //: 0
  String? customerName; //: “String”,
  bool? isValid;

  TestModel({
    this.formulirId,
    this.formulirNumber,
    this.createdDate,
    this.customerId,
    this.customerName,
    this.isValid,
  }); //: true

  TestModel fromJson(Map<String, dynamic> json) {
    return TestModel(
        formulirId: json["formulirId"] as int?,
        formulirNumber: json["formulirNumber"] as String?,
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json['createdDate'] as String),
        customerId: json["customerId"] as int?,
        customerName: json["customerName"] as String?,
        isValid: json["isValid"] as bool?);
  }

  Map<String, dynamic> toJson() {
    return {
      'formulirId': formulirId,
      'formulirNumber': formulirNumber,
      'createdDate': createdDate,
      'customerId': customerId,
      'customerName': customerName,
      'isValid': isValid
    };
  }
}
