import 'package:json_annotation/json_annotation.dart';

import '../price/price.dart';

part 'ticket_offer.g.dart';

@JsonSerializable(createToJson: false)
class TicketOffer {
  final int id;
  final String title;
  @JsonKey(name: 'time_range')
  final List<String> timeRange;
  final Price price;

  TicketOffer({
    required this.id,
    required this.title,
    required this.timeRange,
    required this.price,
  });

  factory TicketOffer.fromJson(Map<String, dynamic> json) => _$TicketOfferFromJson(json);
}
