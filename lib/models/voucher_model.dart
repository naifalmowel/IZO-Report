import 'package:equatable/equatable.dart';

class VoucherModel extends Equatable{
  VoucherModel({
    required this.id,
    required this.date,
    required this.contact,
    required this.total,
    required this.vouNo,
    this.billId,
    required this.type,
    required this.note,
    required this.account,

  });

  int id;  String vouNo;
  String contact;
  String account;
  String note;
  String type;
  List<String?>? billId;
  double total;
  DateTime date;

  @override
  List<Object?> get props => [id,vouNo,contact,account,note,type,billId,total,date];


}
