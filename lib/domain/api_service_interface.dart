import 'package:effective_mobile_test/domain/models/direct_flight.dart';
import 'package:effective_mobile_test/domain/models/musical_direction.dart';
import 'package:effective_mobile_test/domain/models/ticket.dart';

abstract interface class ApiServiceInterface {
  Future<List<MusicalDirection>> getMusicTickets();
  Future<List<DirectFlight>> getTicketOffers();
  Future<List<Ticket>> getAlltickets();
}
