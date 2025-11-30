import 'package:flutter/material.dart';

class ResultViewModel extends ChangeNotifier {
  int totalDays = 0;
  int passedDays = 0;
  int leftDays = 0;
  double progress = 0.0;

  void loadData() {
    notifyListeners();
  }
}
