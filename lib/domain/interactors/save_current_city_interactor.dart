import 'dart:developer';

import 'package:effective_mobile_test/domain/interfaces/db_i.dart';

final class SaveCurrentCityInteractor {
  final DbI saveDestinationI;
  SaveCurrentCityInteractor(this.saveDestinationI);

  Future<void> call(String name) async {
    try {
      return await saveDestinationI.saveCurrentCity(name);
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
