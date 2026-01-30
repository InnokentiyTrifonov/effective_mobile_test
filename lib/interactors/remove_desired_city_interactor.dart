import 'dart:developer';

import 'package:effective_mobile_test/interfaces/db_i.dart';

final class RemoveDesiredCityInteractor {
  final DbI saveDestinationI;
  RemoveDesiredCityInteractor(this.saveDestinationI);

  Future<void> call() async {
    try {
      return await saveDestinationI.removeDesiredCity();
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
