part of 'local_history_bloc.dart';

sealed class LocalHistoryEvent extends Equatable {
  const LocalHistoryEvent();
}

final class GetSavedCities extends LocalHistoryEvent {
  const GetSavedCities({required this.currentCityKey, required this.desiredCityKey});
  final String currentCityKey;
  final String desiredCityKey;
  @override
  List<Object?> get props => [currentCityKey, desiredCityKey];
}

final class SaveCity extends LocalHistoryEvent {
  const SaveCity({
    required this.key,
    required this.city,
  });
  final String key;
  final String city;

  @override
  List<Object?> get props => [key, city];
}

final class RemoveCity extends LocalHistoryEvent {
  const RemoveCity({
    required this.key,
  });
  final String key;

  @override
  List<Object?> get props => [key];
}

final class SwitchCities extends LocalHistoryEvent {
  final String currentCityKey;
  final String desiredCityKey;

  const SwitchCities({required this.currentCityKey, required this.desiredCityKey});
  @override
  List<Object?> get props => [currentCityKey, desiredCityKey];
}
