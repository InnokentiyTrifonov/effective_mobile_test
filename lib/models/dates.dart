class Dates {
  static final Dates _instance = Dates._internal();
  DateTime? departureDate;
  DateTime? reverseDepartureDate;

  factory Dates() {
    return _instance;
  }

  Dates._internal();
}
