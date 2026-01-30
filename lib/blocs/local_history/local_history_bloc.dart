import 'package:effective_mobile_test/interactors/get_current_city_interactor.dart';
import 'package:effective_mobile_test/interactors/get_desired_city_interactor.dart';
import 'package:effective_mobile_test/interactors/remove_current_city_interactor.dart';
import 'package:effective_mobile_test/interactors/remove_desired_city_interactor.dart';
import 'package:effective_mobile_test/interactors/save_current_city_interactor.dart';
import 'package:effective_mobile_test/interactors/save_desired_city_interactor.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'local_history_event.dart';
part 'local_history_state.dart';

class LocalHistoryBloc extends Bloc<LocalHistoryEvent, LocalHistoryState> {
  final GetCurrentCityInteractor getCurrentCity;
  final GetDesiredCityInteractor getDesiredCity;
  final SaveCurrentCityInteractor saveCurrentCity;
  final SaveDesiredCityInteractor saveDesiredCity;
  final RemoveCurrentCityInteractor removeCurrentCity;
  final RemoveDesiredCityInteractor removeDesiredCity;
  LocalHistoryBloc(
    this.getCurrentCity,
    this.getDesiredCity,
    this.saveCurrentCity,
    this.saveDesiredCity,
    this.removeCurrentCity,
    this.removeDesiredCity,
  ) : super(LocalHistoryInitial()) {
    on<LocalHistoryEvent>(
      (event, emit) => switch (event) {
        GetSavedCities() => _getSavedCities(emit),
        SaveCurrentCity(:final city) => _saveCurrentCity(city, emit),
        SaveDesiredCity(:final city) => _saveDesiredCity(city, emit),
        RemoveCurrentCity() => _removeCurrentCity(emit),
        RemoveDesiredCity() => _removeDesiredCity(emit),
        SwitchCities() => _switchCities(emit),
      },
    );
  }

  void _getSavedCities(Emitter<LocalHistoryState> emit) {
    try {
      final currentCity = getCurrentCity();
      final desiredCity = getDesiredCity();
      emit(CitiesSuccessfullyReceived(currentCity: currentCity, desiredCity: desiredCity));
    } on Exception catch (error) {
      emit(GettingCitiesFailed(message: error.toString()));
    }
  }

  Future<void> _switchCities(Emitter<LocalHistoryState> emit) async {
    try {
      final currentCity = getCurrentCity();
      final desiredCity = getDesiredCity();

      if (currentCity != null && desiredCity != null) {
        await saveCurrentCity(desiredCity);
        await saveDesiredCity(currentCity);
      }

      final switchedCurrentCity = getCurrentCity();
      final switchedDesiredCity = getDesiredCity();

      emit(
        CitiesSuccessfullyReceived(
          currentCity: switchedCurrentCity,
          desiredCity: switchedDesiredCity,
        ),
      );
    } on Exception catch (error) {
      emit(GettingCitiesFailed(message: error.toString()));
    }
  }

  Future<void> _saveCurrentCity(String city, Emitter<LocalHistoryState> emit) async {
    try {
      await saveCurrentCity(city);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> _saveDesiredCity(String city, Emitter<LocalHistoryState> emit) async {
    try {
      await saveDesiredCity(city);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> _removeCurrentCity(Emitter<LocalHistoryState> emit) async {
    try {
      await removeCurrentCity();
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> _removeDesiredCity(Emitter<LocalHistoryState> emit) async {
    try {
      await removeDesiredCity();
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }
}
