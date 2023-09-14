import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_03/models/money_model.dart';
import 'package:hive_03/views/home_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyModelAdapter());
  await Hive.openBox('moneySave');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeView(),
    );
  }
}
