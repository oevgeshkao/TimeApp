import 'package:flutter/material.dart';
import '../services/history_storage.dart';
import '../models/countdown_model.dart';
import 'result_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final storage = HistoryStorage();
  List<CountdownModel> items = [];

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    items = await storage.loadHistory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("История"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              await storage.clear();
              await loadHistory();
            },
          )
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text("История пуста"))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title: Text(
              "${item.startDate.toString().split(' ').first} → "
                  "${item.endDate.toString().split(' ').first}",
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                await storage.deleteItem(index);
                await loadHistory();
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ResultScreen(
                    start: item.startDate,
                    end: item.endDate,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
