// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'luggage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Luggage _$LuggageFromJson(Map<String, dynamic> json) => Luggage(
  hasLuggage: json['has_luggage'] as bool,
  price: json['price'] == null
      ? null
      : Price.fromJson(json['price'] as Map<String, dynamic>),
);
