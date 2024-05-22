import 'package:json_annotation/json_annotation.dart';
import '../arrival/arrival.dart';
import '../departure/departure.dart';
import '../hand_luggage/hand_luggage.dart';
import '../luggage/luggage.dart';
import '../price/price.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  final int id;
  final String? badge;
  final Price price;
  final String provider_name;
  final String company;
  final Departure departure;
  final Arrival arrival;
  final bool has_transfer;
  final bool has_visa_transfer;
  final Luggage luggage;
  final HandLuggage hand_luggage;
  final bool is_returnable;
  final bool is_exchangable;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Ticket({
    required this.id,
    required this.badge,
    required this.price,
    required this.provider_name,
    required this.company,
    required this.departure,
    required this.arrival,
    required this.has_transfer,
    required this.has_visa_transfer,
    required this.luggage,
    required this.hand_luggage,
    required this.is_returnable,
    required this.is_exchangable,
  });
}
