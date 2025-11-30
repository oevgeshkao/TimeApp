import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/holiday_model.dart';

class HolidayService {
  Future<List<Holiday>> getHolidaysForYear(int year, String country) async {
    final url = Uri.parse(
        "https://date.nager.at/api/v3/PublicHolidays/$year/$country");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Не удалось загрузить праздники");
    }

    final List data = json.decode(response.body);
    return data.map((e) => Holiday.fromJson(e)).toList();
  }

  Future<List<Holiday>> getHolidaysInRange(
      DateTime start, DateTime end, String country) async {
    List<Holiday> all = [];

    final years = {start.year, end.year};

    for (var year in years) {
      all.addAll(await getHolidaysForYear(year, country));
    }

    return all.where((h) {
      return h.date.isAfter(start.subtract(const Duration(days: 1))) &&
          h.date.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }
}
