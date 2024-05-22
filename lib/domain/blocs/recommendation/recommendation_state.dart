part of 'recommendation_bloc.dart';

sealed class RecommendationState extends Equatable {
  const RecommendationState();
}

final class RecommendationInitial extends RecommendationState {
  @override
  List<Object> get props => [];
}

final class RecommendationSuccessfulReceived extends RecommendationState {
  const RecommendationSuccessfulReceived({required this.recommendations});
  final List<Recommendation> recommendations;

  @override
  List<Object?> get props => [recommendations];
}

final class RecommendationReceivedFailed extends RecommendationState {
  const RecommendationReceivedFailed({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
