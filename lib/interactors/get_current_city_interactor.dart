import 'dart:developer';

import 'package:effective_mobile_test/interfaces/db_i.dart';

final class GetCurrentCityInteractor {
  final DbI saveDestinationI;
  GetCurrentCityInteractor(this.saveDestinationI);

  String? call() {
    try {
      return saveDestinationI.getCurrentCity();
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
