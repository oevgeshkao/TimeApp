import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  DateTime? startDate;
  DateTime? endDate;

  void setStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
  }
}
