import 'dart:developer';

import 'package:effective_mobile_test/domain/interfaces/api_service_i.dart';
import 'package:effective_mobile_test/domain/models/musical_direction.dart';

final class GetMusicTicketsInteractor {
  final ApiServiceI apiServiceI;
  GetMusicTicketsInteractor(this.apiServiceI);

  Future<List<MusicalDirection>> call() async {
    try {
      return await apiServiceI.getMusicTickets();
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
