class Ticket {
  final String? badge;
  final int price;
  final DateTime departureDate;
  final String departureAirport;
  final DateTime arrivalDate;
  final String arrivalAirport;
  final Duration flightTime;
  final bool hasTransfer;

  Ticket({
    required this.badge,
    required this.price,
    required this.departureDate,
    required this.departureAirport,
    required this.arrivalDate,
    required this.arrivalAirport,
    required this.flightTime,
    required this.hasTransfer,
  });
}
