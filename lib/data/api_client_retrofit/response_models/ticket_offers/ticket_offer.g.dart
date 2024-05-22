// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketOffer _$TicketOfferFromJson(Map<String, dynamic> json) => TicketOffer(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      time_range: (json['time_range'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TicketOfferToJson(TicketOffer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'time_range': instance.time_range,
      'price': instance.price,
    };
