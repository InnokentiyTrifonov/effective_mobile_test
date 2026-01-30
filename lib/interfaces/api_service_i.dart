import 'package:effective_mobile_test/models/direct_flight.dart';
import 'package:effective_mobile_test/models/musical_direction.dart';
import 'package:effective_mobile_test/models/ticket.dart';

abstract interface class ApiServiceI {
  Future<List<MusicalDirection>> getMusicTickets();
  Future<List<DirectFlight>> getTicketOffers();
  Future<List<Ticket>> getAlltickets();
}
