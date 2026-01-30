import 'package:json_annotation/json_annotation.dart';

part 'departure.g.dart';

@JsonSerializable(createToJson: false)
class Departure {
  final String town;
  final DateTime date;
  final String airport;

  Departure({required this.town, required this.date, required this.airport});

  factory Departure.fromJson(Map<String, dynamic> json) => _$DepartureFromJson(json);
}
