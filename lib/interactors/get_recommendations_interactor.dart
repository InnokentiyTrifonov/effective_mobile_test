import 'dart:developer';

import 'package:effective_mobile_test/interfaces/recommendation_i.dart';
import 'package:effective_mobile_test/models/recommendation.dart';

final class GetRecommendationsInteractor {
  final RecommendationServiceI recommendationI;
  GetRecommendationsInteractor(this.recommendationI);

  List<Recommendation> call() {
    try {
      return recommendationI.getRecommendations();
    } on Exception catch (e) {
      // here we can send crash info to some crashlytic service
      log(e.toString());
      rethrow;
    }
  }
}
