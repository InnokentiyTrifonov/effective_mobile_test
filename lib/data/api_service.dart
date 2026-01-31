import 'package:effective_mobile_test/core/clients/api_client.dart';
import 'package:effective_mobile_test/core/clients/response_models/offers/offers.dart';
import 'package:effective_mobile_test/core/extensions/offer_extensions.dart';
import 'package:effective_mobile_test/domain/interfaces/api_service_i.dart';
import 'package:effective_mobile_test/domain/models/direct_flight.dart';
import 'package:effective_mobile_test/domain/models/musical_direction.dart';
import 'package:effective_mobile_test/domain/models/ticket.dart';

class ApiService implements ApiServiceI {
  final ApiClient client;
  ApiService({required this.client});

  @override
  Future<List<MusicalDirection>> getMusicTickets() async {
    final Offers response = await client.getMusicTickets();
    final toDomainResponse = response.offers.map((offer) {
      return MusicalDirection(
        image: offer.image,
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
    final toDomainResponse = response.ticketsOffers.map((offer) {
      return DirectFlight(
        colorOfAvatar: offer.avatarColor,
        nameOfAirline: offer.title,
        timeRange: offer.timeRange.join('   '),
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
        hasTransfer: ticket.hasTransfer,
      );
    }).toList();

    return toDomainResponse;
  }
}
