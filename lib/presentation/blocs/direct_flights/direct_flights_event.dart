part of 'direct_flights_bloc.dart';

sealed class DirectFlightsEvent extends Equatable {
  const DirectFlightsEvent();
}

final class ReciveDirectFlights extends DirectFlightsEvent {
  @override
  List<Object?> get props => [];
}
