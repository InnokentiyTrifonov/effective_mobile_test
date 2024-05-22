import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../response_models/offers/offers.dart';
import '../response_models/ticket_offers/tickets_offers.dart';
import '../response_models/tickets/tickets.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://run.mocky.io/v3')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  /// request for music section data
  @GET('/214a1713-bac0-4853-907c-a1dfc3cd05fd')
  Future<Offers> getMusicTickets();

  /// request to receive ticket offers
  @GET('/7e55bf02-89ff-4847-9eb7-7d83ef884017')
  Future<TicketsOffers> getTicketOffers();

  /// request to get all tickets
  @GET('/670c3d56-7f03-4237-9e34-d437a9e56ebf')
  Future<Tickets> getAllTickets();
}
