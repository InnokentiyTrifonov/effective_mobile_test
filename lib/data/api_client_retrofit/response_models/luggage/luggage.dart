import 'package:json_annotation/json_annotation.dart';
import '../price/price.dart';

part 'luggage.g.dart';

@JsonSerializable()
class Luggage {
  final bool has_luggage;
  final Price? price;

  Luggage({
    required this.has_luggage,
    this.price,
  });

  factory Luggage.fromJson(Map<String, dynamic> json) => _$LuggageFromJson(json);
}
