import 'dart:developer';

import 'package:effective_mobile_test/interfaces/db_i.dart';

final class GetDesiredCityInteractor {
  final DbI saveDestinationI;
  GetDesiredCityInteractor(this.saveDestinationI);

  String? call() {
    try {
      return saveDestinationI.getDesiredCity();
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
