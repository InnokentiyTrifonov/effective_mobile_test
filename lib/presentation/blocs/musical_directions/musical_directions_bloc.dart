import 'package:effective_mobile_test/domain/interactors/get_music_tickets_interactor.dart';
import 'package:effective_mobile_test/domain/models/musical_direction.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'musical_directions_event.dart';
part 'musical_directions_state.dart';

class MusicalDirectionsBloc extends Bloc<MusicalDirectionsEvent, MusicalDirectionsState> {
  final GetMusicTicketsInteractor getMusicTicketsInteractor;
  MusicalDirectionsBloc(this.getMusicTicketsInteractor) : super(MusicalDirectionsInitial()) {
    on<LoadMusicalDirections>(_loadMusicalDirections);
  }

  Future<void> _loadMusicalDirections(
    LoadMusicalDirections event,
    Emitter<MusicalDirectionsState> emit,
  ) async {
    try {
      emit(
        MusicalDirectionsSuccessfulReceived(musicalDirections: await getMusicTicketsInteractor()),
      );
    } on Exception catch (error) {
      emit(MusicalDirectionsReceivedFailed(message: error.toString()));
    }
  }
}
