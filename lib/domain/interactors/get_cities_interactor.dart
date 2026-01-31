import 'dart:developer';

import 'package:effective_mobile_test/domain/interfaces/db_i.dart';

final class GetCitiesInteractor {
  final DbI db;
  GetCitiesInteractor(this.db);

  (String?, String?) call() {
    try {
      final currentCity = db.getCurrentCity();
      final desiredCity = db.getDesiredCity();
      return (currentCity, desiredCity);
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
