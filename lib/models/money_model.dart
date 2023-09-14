import 'package:hive/hive.dart';

part "money_model.g.dart";

@HiveType(typeId: 1)
class MoneyModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  int money;

  MoneyModel(
      {required this.description, required this.money, required this.title});
}
