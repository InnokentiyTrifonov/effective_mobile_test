import 'package:effective_mobile_test/core/clients/response_models/offers/offer.dart';
import 'package:effective_mobile_test/core/clients/response_models/ticket_offers/ticket_offer.dart';
import 'package:effective_mobile_test/core/theme/color_resources.dart';
import 'package:effective_mobile_test/core/theme/drawable_resources.dart';
import 'package:flutter/material.dart';

extension ImageProvider on Offer {
  String? get image => switch (id) {
    1 => ImageResource.dieAntwood,
    2 => ImageResource.sokratAndLera,
    3 => ImageResource.lampabickt,
    _ => null,
  };
}

extension ColorProvider on TicketOffer {
  Color? get avatarColor => switch (id) {
    1 => ColorResource.red,
    10 => ColorResource.blue,
    30 => ColorResource.white,
    _ => null,
  };
}
