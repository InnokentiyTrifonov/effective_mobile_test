import 'package:json_annotation/json_annotation.dart';

import '../price/price.dart';

part 'luggage.g.dart';

@JsonSerializable(createToJson: false)
class Luggage {
  @JsonKey(name: 'has_luggage')
  final bool hasLuggage;
  final Price? price;

  Luggage({required this.hasLuggage, this.price});

  factory Luggage.fromJson(Map<String, dynamic> json) => _$LuggageFromJson(json);
}
