// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Departure _$DepartureFromJson(Map<String, dynamic> json) => Departure(
      town: json['town'] as String,
      date: DateTime.parse(json['date'] as String),
      airport: json['airport'] as String,
    );

Map<String, dynamic> _$DepartureToJson(Departure instance) => <String, dynamic>{
      'town': instance.town,
      'date': instance.date.toIso8601String(),
      'airport': instance.airport,
    };
