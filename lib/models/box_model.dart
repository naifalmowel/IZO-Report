import 'package:equatable/equatable.dart';

class BoxModel extends Equatable{
  BoxModel({
    required this.name,
    required this.id,
    required this.balance,
    required this.code,
  });

  int id;
  String code;
  String name;
  double balance;

  @override
  List<Object?> get props => [name,id,balance,code];
}
