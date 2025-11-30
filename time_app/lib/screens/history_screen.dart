import 'package:flutter/material.dart';
import '../viewmodels/history_viewmodel.dart';
import 'result_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final vm = HistoryViewModel();

  @override
  void initState() {
    super.initState();
    vm.loadHistory();
    vm.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("История"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: vm.clear,
          )
        ],
      ),
      body: vm.items.isEmpty
          ? const Center(child: Text("История пуста"))
          : ListView.builder(
        itemCount: vm.items.length,
        itemBuilder: (context, index) {
          final item = vm.items[index];

          return ListTile(
            title: Text(
              "${item.startDate.toString().split(' ').first} → "
                  "${item.endDate.toString().split(' ').first}",
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => vm.deleteItem(index),
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
