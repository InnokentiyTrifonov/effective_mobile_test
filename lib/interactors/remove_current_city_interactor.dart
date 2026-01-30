import 'dart:developer';

import 'package:effective_mobile_test/interfaces/db_i.dart';

final class RemoveCurrentCityInteractor {
  final DbI saveDestinationI;
  RemoveCurrentCityInteractor(this.saveDestinationI);

  Future<void> call() async {
    try {
      return await saveDestinationI.removeCurrentCity();
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
