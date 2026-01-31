import 'dart:developer';

import 'package:effective_mobile_test/domain/interfaces/db_i.dart';

final class SwitchCitiesInteractor {
  final DbI db;
  SwitchCitiesInteractor(this.db);

  Future<(String?, String?)> call() async {
    try {
      final currentCity = db.getCurrentCity();
      final desiredCity = db.getDesiredCity();

      if (currentCity != null && desiredCity != null) {
        await db.saveCurrentCity(desiredCity);
        await db.saveDesiredCity(currentCity);
      }

      return (desiredCity, currentCity);
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
