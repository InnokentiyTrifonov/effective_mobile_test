import 'package:effective_mobile_test/interactors/get_ticket_offers_interactor.dart';
import 'package:effective_mobile_test/models/direct_flight.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'direct_flights_event.dart';
part 'direct_flights_state.dart';

class DirectFlightsBloc extends Bloc<DirectFlightsEvent, DirectFlightsState> {
  final GetTicketOffersInteractor getTicketOffersInteractor;
  DirectFlightsBloc(this.getTicketOffersInteractor) : super(DirectFlightsInitial()) {
    on<ReciveDirectFlights>(_reciveDirectFlights);
  }

  Future<void> _reciveDirectFlights(ReciveDirectFlights _, Emitter<DirectFlightsState> emit) async {
    try {
      final response = await getTicketOffersInteractor();
      emit(DirectFlightsSuccessfulReceived(directFlights: response));
    } on Exception catch (error) {
      emit(DirectFlightsReceivedFailed(message: error.toString()));
    }
  }
}
