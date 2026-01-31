import 'package:json_annotation/json_annotation.dart';

part 'hand_luggage.g.dart';

@JsonSerializable(createToJson: false)
class HandLuggage {
  @JsonKey(name: 'has_hand_luggage')
  final bool hasHandLuggage;
  final String? size;

  HandLuggage({required this.hasHandLuggage, this.size});

  factory HandLuggage.fromJson(Map<String, dynamic> json) => _$HandLuggageFromJson(json);
}
