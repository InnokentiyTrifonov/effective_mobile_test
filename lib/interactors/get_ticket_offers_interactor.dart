import 'dart:developer';

import 'package:effective_mobile_test/interfaces/api_service_i.dart';
import 'package:effective_mobile_test/models/direct_flight.dart';

final class GetTicketOffersInteractor {
  final ApiServiceI apiServiceI;
  GetTicketOffersInteractor(this.apiServiceI);

  Future<List<DirectFlight>> call() async {
    try {
      return await apiServiceI.getTicketOffers();
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
