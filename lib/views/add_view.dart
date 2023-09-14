import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_03/models/money_model.dart';
import 'package:hive_03/views/home_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  late final Box moneyBox;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    moneyBox = Hive.box('moneySave');
    super.initState();
  }

  createData() {
    MoneyModel moneyModel = MoneyModel(
        description: _descriptionController.text,
        money: int.parse(_moneyController.text),
        title: _titleController.text);

    moneyBox.add(moneyModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Title"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _moneyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Money"),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Desc"),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                createData();
                Get.offAll(() => HomeView());
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
