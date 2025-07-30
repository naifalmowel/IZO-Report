import 'package:equatable/equatable.dart';

class ExpenseModel extends Equatable {
  ExpenseModel({
    required this.id,
    required this.date,
    required this.note,
    required this.total,
    required this.expNo,
  });

  int id;
  double total;
  DateTime date;
  String expNo;
  String note;

  @override
  List<Object?> get props => [
        id,
        date,
        note,
        total,
        expNo,
      ];
}
