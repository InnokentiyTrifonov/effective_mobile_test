import 'package:effective_mobile_test/core/theme/drawable_resources.dart';
import 'package:effective_mobile_test/core/theme/string_resources.dart';
import 'package:effective_mobile_test/interfaces/recommendation_i.dart';
import 'package:effective_mobile_test/models/recommendation.dart';

final class RecommendationService implements RecommendationServiceI {
  @override
  List<Recommendation> getRecommendations() => [
    Recommendation(image: ImageResource.stambul, city: StringResource.stambul),
    Recommendation(image: ImageResource.sochi, city: StringResource.sochi),
    Recommendation(image: ImageResource.phuket, city: StringResource.phuket),
  ];
}
