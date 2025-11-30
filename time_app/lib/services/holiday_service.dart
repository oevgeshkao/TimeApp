import 'dart:convert';
import 'package:http/http.dart' as http;

class Holiday {
  final String name;
  final DateTime date;

  Holiday({required this.name, required this.date});

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      name: json["localName"] ?? json["name"],
      date: DateTime.parse(json["date"]),
    );
  }
}

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

  /// Получить праздники за диапазон дат
  Future<List<Holiday>> getHolidaysInRange(
      DateTime start, DateTime end, String country) async {
    List<Holiday> all = [];

    // Загружаем праздники двух годов (если диапазон пересекает год)
    final years = {start.year, end.year};

    for (var year in years) {
      all.addAll(await getHolidaysForYear(year, country));
    }

    // Фильтрация по диапазону
    return all.where((h) {
      return h.date.isAfter(start.subtract(const Duration(days: 1))) &&
          h.date.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }
}
