// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketOffer _$TicketOfferFromJson(Map<String, dynamic> json) => TicketOffer(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  timeRange: (json['time_range'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  price: Price.fromJson(json['price'] as Map<String, dynamic>),
);
