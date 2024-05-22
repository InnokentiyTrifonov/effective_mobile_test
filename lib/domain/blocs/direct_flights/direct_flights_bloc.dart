import 'package:effective_mobile_test/domain/api_service_interface.dart';
import 'package:effective_mobile_test/domain/models/direct_flight.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'direct_flights_event.dart';
part 'direct_flights_state.dart';

class DirectFlightsBloc extends Bloc<DirectFlightsEvent, DirectFlightsState> {
  DirectFlightsBloc({required ApiServiceInterface contractImpl}) : super(DirectFlightsInitial()) {
    on<ReciveDirectFlights>((event, emit) async {
      try {
        final response = await contractImpl.getTicketOffers();
        emit(DirectFlightsSuccessfulReceived(directFlights: response));
      } on Exception catch (error) {
        emit(DirectFlightsReceivedFailed(message: error.toString()));
      }
    });
  }
}
