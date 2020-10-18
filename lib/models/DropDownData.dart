class DropDownData {
  String productName;

  DropDownData({
    this.productName,
  });

  factory DropDownData.fromJson(Map<String, dynamic> json) {
    return DropDownData(
      productName: json['productName'],
    );
  }
}
