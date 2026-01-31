import 'package:effective_mobile_test/core/clients/response_models/ticket_offers/ticket_offer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tickets_offers.g.dart';

@JsonSerializable(createToJson: false)
class TicketsOffers {
  @JsonKey(name: 'tickets_offers')
  final List<TicketOffer> ticketsOffers;

  TicketsOffers({required this.ticketsOffers});

  factory TicketsOffers.fromJson(Map<String, dynamic> json) => _$TicketsOffersFromJson(json);
}
