import 'package:effective_mobile_test/domain/models/musical_direction.dart';

import 'package:effective_mobile_test/domain/api_service_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'musical_directions_event.dart';
part 'musical_directions_state.dart';

class MusicalDirectionsBloc extends Bloc<MusicalDirectionsEvent, MusicalDirectionsState> {
  MusicalDirectionsBloc({required ApiServiceInterface contractImpl}) : super(MusicalDirectionsInitial()) {
    on<LoadMusicalDirections>((event, emit) async {
      try {
        emit(MusicalDirectionsSuccessfulReceived(musicalDirections: await contractImpl.getMusicTickets()));
      } on Exception catch (error) {
        emit(MusicalDirectionsReceivedFailed(message: error.toString()));
      }
    });
  }
}
