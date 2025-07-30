import 'package:izo_report/models/table_model.dart';

class HallModel {
  HallModel({
    required this.tables,
    required this.name,
    required this.id,
    required this.tableCount,
  });

  int id;
  int tableCount;

  String name;

  List<TableModel> tables;
}