import 'package:json_annotation/json_annotation.dart';

part 'arrival.g.dart';

@JsonSerializable(createToJson: false)
class Arrival {
  final String town;
  final DateTime date;
  final String airport;

  Arrival({required this.town, required this.date, required this.airport});

  factory Arrival.fromJson(Map<String, dynamic> json) => _$ArrivalFromJson(json);
}
