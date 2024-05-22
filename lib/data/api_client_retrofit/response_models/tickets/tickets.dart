import 'package:effective_mobile_test/data/api_client_retrofit/response_models/tickets/ticket.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tickets.g.dart';

@JsonSerializable()
class Tickets {
  final List<Ticket> tickets;

  Tickets({
    required this.tickets,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) => _$TicketsFromJson(json);
}
