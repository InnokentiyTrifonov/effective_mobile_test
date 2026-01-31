part of 'musical_directions_bloc.dart';

sealed class MusicalDirectionsState extends Equatable {
  const MusicalDirectionsState();
}

final class MusicalDirectionsInitial extends MusicalDirectionsState {
  @override
  List<Object> get props => [];
}

final class MusicalDirectionsSuccessfulReceived extends MusicalDirectionsState {
  const MusicalDirectionsSuccessfulReceived({required this.musicalDirections});
  final List<MusicalDirection> musicalDirections;

  @override
  List<Object?> get props => [musicalDirections];
}

final class MusicalDirectionsReceivedFailed extends MusicalDirectionsState {
  const MusicalDirectionsReceivedFailed({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
