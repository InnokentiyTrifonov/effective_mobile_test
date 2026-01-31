import 'package:json_annotation/json_annotation.dart';

import 'offer.dart';

part 'offers.g.dart';

@JsonSerializable(createToJson: false)
class Offers {
  Offers({required this.offers});

  final List<Offer> offers;

  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);
}
