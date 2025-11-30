import 'package:flutter/material.dart';
import '../viewmodels/result_viewmodel.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key});

  final vm = ResultViewModel();

  @override
  Widget build(BuildContext context) {
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

            const Text(
              "XX дней",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            const LinearProgressIndicator(
              value: 0.5,
              minHeight: 12,
            ),

            const SizedBox(height: 20),

            const Text("Прошло: YY дней", style: TextStyle(fontSize: 16)),
            const Text("Всего: ZZ дней", style: TextStyle(fontSize: 16)),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: null,
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
