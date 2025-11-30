import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final DateTime start;
  final DateTime end;

  ResultScreen({
    super.key,
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    final totalDays = end.difference(start).inDays;
    final passedDays = DateTime.now().difference(start).inDays;
    final leftDays = end.difference(DateTime.now()).inDays;
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
                  fontSize: 40, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
            ),

            const SizedBox(height: 20),

            Text("Прошло: $passedDays дней",
                style: const TextStyle(fontSize: 16)),
            Text("Всего: $totalDays дней",
                style: const TextStyle(fontSize: 16)),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text("Назад"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
