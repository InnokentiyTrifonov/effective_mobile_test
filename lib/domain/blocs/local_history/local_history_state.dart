part of 'local_history_bloc.dart';

sealed class LocalHistoryState extends Equatable {
  const LocalHistoryState();
}

final class LocalHistoryInitial extends LocalHistoryState {
  @override
  List<Object> get props => [];
}

final class CitiesSuccessfullyReceived extends LocalHistoryState {
  const CitiesSuccessfullyReceived({this.currentCity, this.desiredCity});
  final String? currentCity;
  final String? desiredCity;

  @override
  List<Object?> get props => [currentCity, desiredCity];
}

final class GettingCitiesFailed extends LocalHistoryState {
  const GettingCitiesFailed({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
