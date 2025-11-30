import 'package:flutter/material.dart';
import '../models/countdown_model.dart';
import '../services/history_storage.dart';

class HistoryViewModel extends ChangeNotifier {
  final storage = HistoryStorage();
  List<CountdownModel> items = [];

  Future<void> loadHistory() async {
    items = await storage.loadHistory();
    notifyListeners();
  }

  Future<void> deleteItem(int index) async {
    await storage.deleteItem(index);
    await loadHistory();
  }

  Future<void> clear() async {
    await storage.clear();
    await loadHistory();
  }
}
