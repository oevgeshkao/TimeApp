import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/countdown_model.dart';

class HistoryStorage {
  static const key = "history_items";

  Future<List<CountdownModel>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(key) ?? [];
    return jsonList
        .map((e) => CountdownModel.fromJson(json.decode(e)))
        .toList();
  }

  Future<void> addItem(CountdownModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    list.add(json.encode(model.toJson()));
    await prefs.setStringList(key, list);
  }

  Future<void> deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];
    list.removeAt(index);
    await prefs.setStringList(key, list);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
