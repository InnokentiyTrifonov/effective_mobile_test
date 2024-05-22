// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: (json['id'] as num).toInt(),
      badge: json['badge'] as String?,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      provider_name: json['provider_name'] as String,
      company: json['company'] as String,
      departure: Departure.fromJson(json['departure'] as Map<String, dynamic>),
      arrival: Arrival.fromJson(json['arrival'] as Map<String, dynamic>),
      has_transfer: json['has_transfer'] as bool,
      has_visa_transfer: json['has_visa_transfer'] as bool,
      luggage: Luggage.fromJson(json['luggage'] as Map<String, dynamic>),
      hand_luggage:
          HandLuggage.fromJson(json['hand_luggage'] as Map<String, dynamic>),
      is_returnable: json['is_returnable'] as bool,
      is_exchangable: json['is_exchangable'] as bool,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'badge': instance.badge,
      'price': instance.price,
      'provider_name': instance.provider_name,
      'company': instance.company,
      'departure': instance.departure,
      'arrival': instance.arrival,
      'has_transfer': instance.has_transfer,
      'has_visa_transfer': instance.has_visa_transfer,
      'luggage': instance.luggage,
      'hand_luggage': instance.hand_luggage,
      'is_returnable': instance.is_returnable,
      'is_exchangable': instance.is_exchangable,
    };
