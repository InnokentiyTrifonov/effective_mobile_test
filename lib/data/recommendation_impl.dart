import 'package:effective_mobile_test/domain/models/Recommendation.dart';
import 'package:effective_mobile_test/domain/recommendation_interface.dart';
import 'package:effective_mobile_test/theme/drawable_resources.dart';
import 'package:effective_mobile_test/theme/string_resources.dart';

final class RecommendationImpl implements RecommendationInterface {
  @override
  List<Recommendation> getRecommendations() {
    return [
      Recommendation(image: ImageResource.STAMBUL, city: StringResource.STAMBUL),
      Recommendation(image: ImageResource.SOCHI, city: StringResource.SOCHI),
      Recommendation(image: ImageResource.PHUKET, city: StringResource.PHUKET),
    ];
  }
}
