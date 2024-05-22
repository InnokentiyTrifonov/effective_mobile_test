import 'package:effective_mobile_test/data/api_client_retrofit/response_models/offers/offer.dart';
import 'package:effective_mobile_test/data/api_client_retrofit/response_models/ticket_offers/ticket_offer.dart';
import 'package:effective_mobile_test/data/api_client_retrofit/retrofit/api_client.dart';
import 'package:effective_mobile_test/domain/models/direct_flight.dart';
import 'package:effective_mobile_test/domain/models/musical_direction.dart';

import 'package:effective_mobile_test/domain/api_service_interface.dart';
import 'package:effective_mobile_test/domain/models/ticket.dart';
import 'package:effective_mobile_test/theme/color_resources.dart';
import 'package:effective_mobile_test/theme/drawable_resources.dart';
import 'package:flutter/material.dart';

class ApiServiceImpl implements ApiServiceInterface {
  final ApiClient client;
  ApiServiceImpl({required this.client});

  @override
  Future<List<MusicalDirection>> getMusicTickets() async {
    final response = await client.getMusicTickets();
    final toDomainResponse = response.offers.map((offer) {
      return MusicalDirection(
        image: offer.getImageResource(offer.id),
        musicalGroupName: offer.title,
        city: offer.town,
        price: offer.price.value,
      );
    }).toList();
    return toDomainResponse;
  }

  @override
  Future<List<DirectFlight>> getTicketOffers() async {
    final response = await client.getTicketOffers();
    final toDomainResponse = response.tickets_offers.map((offer) {
      return DirectFlight(
        colorOfAvatar: offer.getAvatarColor(offer.id),
        nameOfAirline: offer.title,
        timeRange: offer.time_range.join('   '),
        price: offer.price.value,
      );
    }).toList();
    return toDomainResponse;
  }

  @override
  Future<List<Ticket>> getAlltickets() async {
    final response = await client.getAllTickets();
    final toDomainResponse = response.tickets.map((ticket) {
      return Ticket(
        badge: ticket.badge,
        price: ticket.price.value,
        departureDate: ticket.departure.date,
        departureAirport: ticket.departure.airport,
        arrivalDate: ticket.arrival.date,
        arrivalAirport: ticket.arrival.airport,
        flightTime: ticket.arrival.date.toUtc().difference(ticket.departure.date.toUtc()),
        hasTransfer: ticket.has_transfer,
      );
    }).toList();

    return toDomainResponse;
  }
}

extension on Offer {
  String? getImageResource(int id) {
    switch (id) {
      case 1:
        return ImageResource.DIE_ANTWOOD;
      case 2:
        return ImageResource.SOKRAT_AND_LERA;
      case 3:
        return ImageResource.LAMPABICKT;
      default:
        //TODO NEED DEFAULT IMAGE;
        return null;
    }
  }
}

extension on TicketOffer {
  Color? getAvatarColor(int id) {
    switch (id) {
      case 1:
        return ColorResource.RED;
      case 10:
        return ColorResource.BLUE;
      case 30:
        return ColorResource.WHITE;
      default:
        //TODO NEED DEFAULT COLOR;
        return null;
    }
  }
}
