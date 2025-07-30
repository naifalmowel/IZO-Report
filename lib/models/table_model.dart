
class TableModel {
  TableModel(
      {required this.number,
        required this.hall,
        required this.voidAmount,
        required this.cost,
        required this.waitCustomer,
        required this.time,
        required this.bookingTable,
        required this.bookingDate,
        this.deliveryName,
        this.guestName,
        this.guestMobile,
        this.cashierName,
        this.formatNumber,});
  String number;
  String hall;
  String? deliveryName;
  String? guestName;
  String? guestMobile;
  String? cashierName;
  String? formatNumber;
  double? voidAmount;
  double cost;
  bool? waitCustomer;
  bool? bookingTable;
  DateTime? time;
  DateTime? bookingDate;
}