part of 'musical_directions_bloc.dart';

sealed class MusicalDirectionsEvent extends Equatable {
  const MusicalDirectionsEvent();
}

final class LoadMusicalDirections extends MusicalDirectionsEvent {
  @override
  List<Object?> get props => [];
}
