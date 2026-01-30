import 'dart:developer';

import 'package:effective_mobile_test/interfaces/db_i.dart';

final class SaveDesiredCityInteractor {
  final DbI saveDestinationI;
  SaveDesiredCityInteractor(this.saveDestinationI);

  Future<void> call(String name) async {
    try {
      return await saveDestinationI.saveDesiredCity(name);
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
