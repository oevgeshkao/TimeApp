class CountdownModel {
  final DateTime startDate;
  final DateTime endDate;

  CountdownModel({
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
    "start": startDate.toIso8601String(),
    "end": endDate.toIso8601String(),
  };

  factory CountdownModel.fromJson(Map<String, dynamic> json) {
    return CountdownModel(
      startDate: DateTime.parse(json["start"]),
      endDate: DateTime.parse(json["end"]),
    );
  }
}
