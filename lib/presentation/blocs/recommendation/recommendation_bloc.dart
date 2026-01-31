import 'package:effective_mobile_test/domain/interactors/get_recommendations_interactor.dart';
import 'package:effective_mobile_test/domain/models/recommendation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationBloc extends Bloc<RecommendationEvent, RecommendationState> {
  final GetRecommendationsInteractor getRecommendations;
  RecommendationBloc(this.getRecommendations) : super(RecommendationInitial()) {
    on<GetRecommendations>(_getRecommendations);
  }

  Future<void> _getRecommendations(
    GetRecommendations event,
    Emitter<RecommendationState> emit,
  ) async {
    try {
      emit(RecommendationSuccessfulReceived(recommendations: getRecommendations()));
    } on Exception catch (error) {
      emit(RecommendationReceivedFailed(message: error.toString()));
    }
  }
}
