part of 'local_history_bloc.dart';

sealed class LocalHistoryEvent {}

final class GetSavedCities extends LocalHistoryEvent {}

final class SaveCurrentCity extends LocalHistoryEvent {
  final String city;
  SaveCurrentCity(this.city);
}

final class SaveDesiredCity extends LocalHistoryEvent {
  final String city;
  SaveDesiredCity(this.city);
}

final class RemoveCurrentCity extends LocalHistoryEvent {}

final class RemoveDesiredCity extends LocalHistoryEvent {}

final class SwitchCities extends LocalHistoryEvent {}
