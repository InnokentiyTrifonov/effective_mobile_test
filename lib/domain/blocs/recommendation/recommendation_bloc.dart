import 'package:effective_mobile_test/domain/models/Recommendation.dart';
import 'package:effective_mobile_test/domain/recommendation_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_event.dart';
part 'recommendation_state.dart';

class RecommendationBloc extends Bloc<RecommendationEvent, RecommendationState> {
  RecommendationBloc({required RecommendationInterface contractImpl}) : super(RecommendationInitial()) {
    on<GetRecommendations>((event, emit) {
      try {
        emit(RecommendationSuccessfulReceived(recommendations: contractImpl.getRecommendations()));
      } on Exception catch (error) {
        emit(RecommendationReceivedFailed(message: error.toString()));
      }
    });
  }
}
