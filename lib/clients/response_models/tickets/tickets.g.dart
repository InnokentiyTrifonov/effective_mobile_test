// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tickets _$TicketsFromJson(Map<String, dynamic> json) => Tickets(
  tickets: (json['tickets'] as List<dynamic>)
      .map((e) => Ticket.fromJson(e as Map<String, dynamic>))
      .toList(),
);
