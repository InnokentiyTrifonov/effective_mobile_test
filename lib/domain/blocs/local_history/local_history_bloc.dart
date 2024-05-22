import 'package:effective_mobile_test/domain/save_destination_interface.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'local_history_event.dart';
part 'local_history_state.dart';

class LocalHistoryBloc extends Bloc<LocalHistoryEvent, LocalHistoryState> {
  LocalHistoryBloc({required SaveDestinationInterface contractImpl}) : super(LocalHistoryInitial()) {
    on<GetSavedCities>((event, emit) {
      try {
        final currentCity = contractImpl.getSavedCity(event.currentCityKey);
        final desiredCity = contractImpl.getSavedCity(event.desiredCityKey);
        emit(CitiesSuccessfullyReceived(currentCity: currentCity, desiredCity: desiredCity));
      } on Exception catch (error) {
        emit(GettingCitiesFailed(message: error.toString()));
      }
    });
    on<SwitchCities>((event, emit) {
      try {
        final currentCity = contractImpl.getSavedCity(event.currentCityKey);
        final desiredCity = contractImpl.getSavedCity(event.desiredCityKey);

        if (currentCity != null && desiredCity != null) {
          contractImpl.saveCity(event.currentCityKey, desiredCity);
          contractImpl.saveCity(event.desiredCityKey, currentCity);
        }

        final switchedCurrentCity = contractImpl.getSavedCity(event.currentCityKey);
        final switchedDesiredCity = contractImpl.getSavedCity(event.desiredCityKey);

        emit(CitiesSuccessfullyReceived(currentCity: switchedCurrentCity, desiredCity: switchedDesiredCity));
      } on Exception catch (error) {
        emit(GettingCitiesFailed(message: error.toString()));
      }
    });

    on<SaveCity>((event, emit) {
      try {
        contractImpl.saveCity(event.key, event.city);
      } on Exception catch (error) {
        debugPrint(error.toString());
      }
    });

    on<RemoveCity>((event, emit) {
      try {
        contractImpl.removeCity(event.key);
      } on Exception catch (error) {
        debugPrint(error.toString());
      }
    });
  }
}
