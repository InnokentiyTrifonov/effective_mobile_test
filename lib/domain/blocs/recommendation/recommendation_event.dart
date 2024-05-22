part of 'recommendation_bloc.dart';

sealed class RecommendationEvent extends Equatable {
  const RecommendationEvent();
}

final class GetRecommendations extends RecommendationEvent {
  @override
  List<Object?> get props => [];
}

final class SetDesiredCity extends RecommendationEvent {
  final String desiredCity;

  const SetDesiredCity({required this.desiredCity});

  @override
  List<Object?> get props => [desiredCity];
}
