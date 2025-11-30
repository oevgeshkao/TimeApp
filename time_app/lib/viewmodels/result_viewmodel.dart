import 'package:flutter/material.dart';

class ResultViewModel extends ChangeNotifier {
  int totalDays = 0;
  int passedDays = 0;
  int leftDays = 0;
  double progress = 0.0;

  void calculate(DateTime start, DateTime end) {
    totalDays = end.difference(start).inDays;
    passedDays = DateTime.now().difference(start).inDays;
    leftDays = end.difference(DateTime.now()).inDays;
    progress = (passedDays / totalDays).clamp(0.0, 1.0);

    notifyListeners();
  }
}
