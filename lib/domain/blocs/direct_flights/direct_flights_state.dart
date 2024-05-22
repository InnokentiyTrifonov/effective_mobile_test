part of 'direct_flights_bloc.dart';

sealed class DirectFlightsState extends Equatable {
  const DirectFlightsState();
}

final class DirectFlightsInitial extends DirectFlightsState {
  @override
  List<Object> get props => [];
}

final class DirectFlightsSuccessfulReceived extends DirectFlightsState {
  const DirectFlightsSuccessfulReceived({required this.directFlights});
  final List<DirectFlight> directFlights;

  @override
  List<Object?> get props => [directFlights];
}

final class DirectFlightsReceivedFailed extends DirectFlightsState {
  const DirectFlightsReceivedFailed({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
