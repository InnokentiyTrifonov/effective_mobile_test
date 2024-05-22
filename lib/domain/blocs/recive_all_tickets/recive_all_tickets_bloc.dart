import 'package:effective_mobile_test/domain/api_service_interface.dart';
import 'package:effective_mobile_test/domain/models/ticket.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recive_all_tickets_event.dart';
part 'recive_all_tickets_state.dart';

class ReceiveAllTicketsBloc extends Bloc<ReceiveAllTicketsEvent, ReceiveAllTicketsState> {
  ReceiveAllTicketsBloc({required ApiServiceInterface contract}) : super(ReceiveAllTicketsInitial()) {
    on<ReceiveAllTicketsEvent>((event, emit) async {
      try {
        emit(TicketsReceivedSuccesful(tickets: await contract.getAlltickets()));
      } on Exception catch (error) {
        emit(TicketsReceivedFailed(message: error.toString()));
      }
    });
  }
}
