import 'package:json_annotation/json_annotation.dart';

import '../arrival/arrival.dart';
import '../departure/departure.dart';
import '../hand_luggage/hand_luggage.dart';
import '../luggage/luggage.dart';
import '../price/price.dart';

part 'ticket.g.dart';

@JsonSerializable(createToJson: false)
class Ticket {
  final int id;
  final String? badge;
  final Price price;
  @JsonKey(name: 'provider_name')
  final String providerName;
  final String company;
  final Departure departure;
  final Arrival arrival;
  @JsonKey(name: 'has_transfer')
  final bool hasTransfer;
  @JsonKey(name: 'hasVisaTransfer')
  final bool hasVisaTransfer;
  final Luggage luggage;
  @JsonKey(name: 'hand_luggage')
  final HandLuggage handLuggage;
  @JsonKey(name: 'is_returnable')
  final bool isReturnable;
  @JsonKey(name: 'isExchangable')
  final bool isExchangable;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Ticket({
    required this.id,
    required this.badge,
    required this.price,
    required this.providerName,
    required this.company,
    required this.departure,
    required this.arrival,
    required this.hasTransfer,
    required this.hasVisaTransfer,
    required this.luggage,
    required this.handLuggage,
    required this.isReturnable,
    required this.isExchangable,
  });
}
