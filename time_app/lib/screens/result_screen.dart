import 'package:flutter/material.dart';
import '../services/holiday_service.dart';

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
  final service = HolidayService();
  List<Holiday> holidays = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
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
    final totalDays = widget.end.difference(widget.start).inDays;
    final passedDays = DateTime.now().difference(widget.start).inDays;
    final leftDays = widget.end.difference(DateTime.now()).inDays;
    final progress = (passedDays / totalDays).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text("Результат")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "До события осталось:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Text(
              "$leftDays дней",
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
            ),

            const SizedBox(height: 20),

            Text("Прошло: $passedDays дней"),
            Text("Всего: $totalDays дней"),

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
                  ? const Center(
                child: Text("Праздников в диапазоне нет"),
              )
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
