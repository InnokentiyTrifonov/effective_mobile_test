import 'package:effective_mobile_test/data/save_destination/save_destination_service.dart';
import 'package:effective_mobile_test/domain/blocs/local_history/keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  group('Storage tests', () {
    test('Test saving', () async {
      SharedPreferences.setMockInitialValues({});
      final sharedPrefs = await SharedPreferences.getInstance();
      final saveDestinationService = SaveDestinationService(storage: sharedPrefs);
      await saveDestinationService.saveCity(LocalHistoryKeys.currentCity, 'Бишкек');
      final result = saveDestinationService.getSavedCity(LocalHistoryKeys.currentCity);

      expect(result, 'Бишкек');
    });

    test('Test removing', () async {
      SharedPreferences.setMockInitialValues({});
      final sharedPrefs = await SharedPreferences.getInstance();
      final saveDestinationService = SaveDestinationService(storage: sharedPrefs);
      await saveDestinationService.saveCity(LocalHistoryKeys.currentCity, 'Бишкек');
      saveDestinationService.removeCity(LocalHistoryKeys.currentCity);
      final result = saveDestinationService.getSavedCity(LocalHistoryKeys.currentCity);

      expect(result, null);
    });
  });
}
