import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_03/models/money_model.dart';
import 'package:hive_03/views/home_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UpdateView extends StatefulWidget {
  final int? index;
  final MoneyModel? moneyModel;
  final titleController;
  final descriptionController;
  final moneyController;

  const UpdateView(
      {super.key,
      this.index,
      this.moneyModel,
      this.moneyController,
      this.descriptionController,
      this.titleController});

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  late final Box moneyBox;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _moneyController;

  @override
  void initState() {
    // TODO: implement initState
    moneyBox = Hive.box('moneySave');
    _titleController = TextEditingController(text: widget.titleController);
    _descriptionController =
        TextEditingController(text: widget.descriptionController);
    _moneyController =
        TextEditingController(text: widget.moneyController.toString());

    super.initState();
  }

  updateData() {
    MoneyModel newMoney = MoneyModel(
        description: _descriptionController.text,
        money: int.parse(_moneyController.text),
        title: _titleController.text);
    moneyBox.putAt(widget.index!, newMoney);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
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
                updateData();
                Get.offAll(() => HomeView());
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
