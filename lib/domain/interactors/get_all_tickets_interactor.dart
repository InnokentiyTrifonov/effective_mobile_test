import 'dart:developer';

import 'package:effective_mobile_test/domain/interfaces/api_service_i.dart';
import 'package:effective_mobile_test/domain/models/ticket.dart';

final class GetAllTicketsInteractor {
  final ApiServiceI apiServiceI;
  GetAllTicketsInteractor(this.apiServiceI);

  Future<List<Ticket>> call() async {
    try {
      return await apiServiceI.getAlltickets();
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
