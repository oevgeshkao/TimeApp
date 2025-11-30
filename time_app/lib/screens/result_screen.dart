import 'package:flutter/material.dart';
import '../viewmodels/result_viewmodel.dart';
import '../services/holiday_service.dart';
import '../models/holiday_model.dart';

class ResultScreen extends StatefulWidget {
  final DateTime start;
  final DateTime end;

  const ResultScreen({
    super.key,
    required this.start,
    required this.end,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final vm = ResultViewModel();
  final service = HolidayService();
  List<Holiday> holidays = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    vm.calculate(widget.start, widget.end);
    load();
  }

  Future<void> load() async {
    holidays = await service.getHolidaysInRange(
      widget.start,
      widget.end,
      "RU",
    );

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Результат")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "До события осталось:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Text(
              "${vm.leftDays} дней",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            LinearProgressIndicator(
              value: vm.progress,
              minHeight: 12,
            ),

            const SizedBox(height: 20),

            Text("Прошло: ${vm.passedDays} дней"),
            Text("Всего: ${vm.totalDays} дней"),

            const SizedBox(height: 30),
            const Divider(),

            const Text(
              "Праздники в диапазоне:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : holidays.isEmpty
                  ? const Center(child: Text("Праздников в диапазоне нет"))
                  : ListView.builder(
                itemCount: holidays.length,
                itemBuilder: (context, index) {
                  final h = holidays[index];
                  return ListTile(
                    leading: const Icon(Icons.celebration),
                    title: Text(h.name),
                    subtitle: Text(h.date.toString().split(" ").first),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Назад"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
