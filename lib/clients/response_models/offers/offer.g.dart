// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  town: json['town'] as String,
  price: Price.fromJson(json['price'] as Map<String, dynamic>),
);
