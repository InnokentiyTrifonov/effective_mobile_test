import 'package:effective_mobile_test/interactors/get_all_tickets_interactor.dart';
import 'package:effective_mobile_test/models/ticket.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recive_all_tickets_event.dart';
part 'recive_all_tickets_state.dart';

class ReceiveAllTicketsBloc extends Bloc<ReceiveAllTicketsEvent, ReceiveAllTicketsState> {
  final GetAllTicketsInteractor getAllTicketsInteractor;
  ReceiveAllTicketsBloc(this.getAllTicketsInteractor) : super(ReceiveAllTicketsInitial()) {
    on<ReceiveAllTicketsEvent>(_receiveAllTicketsEvent);
  }

  Future<void> _receiveAllTicketsEvent(
    ReceiveAllTicketsEvent event,
    Emitter<ReceiveAllTicketsState> emit,
  ) async {
    try {
      emit(TicketsReceivedSuccesful(tickets: await getAllTicketsInteractor()));
    } on Exception catch (error) {
      emit(TicketsReceivedFailed(message: error.toString()));
    }
  }
}
