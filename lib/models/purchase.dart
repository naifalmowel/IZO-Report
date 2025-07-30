class PurchaseModel {
  PurchaseModel({
    required this.id,
    required this.supplier,
    required this.purNo,
    required this.finalTotal,
    required this.type,
    required this.date,
    required this.payType,
  });

  int id;

  String supplier;

  double finalTotal;
  DateTime date;
  String purNo;
  String type;
  String payType;
}
