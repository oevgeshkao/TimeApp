import 'package:flutter/material.dart';
import '../viewmodels/home_viewmodel.dart';
import '../models/countdown_model.dart';
import '../services/history_storage.dart';
import 'result_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final vm = HomeViewModel();

  final startController = TextEditingController();
  final endController = TextEditingController();

  Future<void> pickStartDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      vm.setStartDate(date);
      startController.text = date.toString().split(" ").first;
      setState(() {});
    }
  }

  Future<void> pickEndDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: vm.startDate ?? DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: vm.startDate ?? DateTime.now(),
    );

    if (date != null) {
      vm.setEndDate(date);
      endController.text = date.toString().split(" ").first;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Обратный отсчёт"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Дата начала",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            TextField(
              controller: startController,
              readOnly: true,
              onTap: pickStartDate,
              decoration: InputDecoration(
                hintText: "Выберите дату начала",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text("Дата окончания",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            TextField(
              controller: endController,
              readOnly: true,
              onTap: pickEndDate,
              decoration: InputDecoration(
                hintText: "Выберите дату окончания",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (vm.startDate != null && vm.endDate != null)
                    ? () async {
                  await HistoryStorage().addItem(
                    CountdownModel(
                      startDate: vm.startDate!,
                      endDate: vm.endDate!,
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResultScreen(
                        start: vm.startDate!,
                        end: vm.endDate!,
                      ),
                    ),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text("Рассчитать"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
