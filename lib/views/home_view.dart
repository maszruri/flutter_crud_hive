import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_03/views/add_view.dart';
import 'package:hive_03/views/update_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final Box moneyBox;

  @override
  void initState() {
    // TODO: implement initState
    moneyBox = Hive.box('moneySave');
    super.initState();
  }

  deleteData(int index) {
    moneyBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Money List"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddView());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: moneyBox.listenable(),
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text("Value is Empty"),
            );
          } else {
            return ListView.builder(
              itemCount: moneyBox.length,
              itemBuilder: (context, index) {
                var box = value;
                var getData = box.getAt(index);

                return Card(
                  child: ListTile(
                    trailing: IconButton(
                      onPressed: () {
                        deleteData(index);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        Get.to(
                          () => UpdateView(
                              descriptionController: getData.description,
                              index: index,
                              moneyController: getData.money,
                              moneyModel: getData,
                              titleController: getData.title),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    title: Text(getData.title),
                    subtitle: Row(
                      children: [
                        Text(getData.description),
                        Text("   |   "),
                        Text("Rp. " + getData.money.toString()),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
