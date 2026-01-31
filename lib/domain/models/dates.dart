class Dates {
  static final Dates _instance = Dates._internal();
  DateTime? departureDate;
  DateTime? reverseDepartureDate;

  factory Dates() => _instance;

  Dates._internal();
}
