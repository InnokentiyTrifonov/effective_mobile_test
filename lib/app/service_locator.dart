import 'package:dio/dio.dart';
import 'package:effective_mobile_test/data/recommendation_impl.dart';
import 'package:effective_mobile_test/data/api_client_retrofit/retrofit/api_client.dart';
import 'package:effective_mobile_test/data/api_service_impl.dart';
import 'package:effective_mobile_test/data/save_destination/save_destination_service.dart';
import 'package:effective_mobile_test/domain/save_destination_interface.dart';
import 'package:effective_mobile_test/domain/navigator/navigation_service.dart';
import 'package:effective_mobile_test/domain/recommendation_interface.dart';
import 'package:effective_mobile_test/domain/api_service_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  locator.registerSingleton<ApiServiceInterface>(ApiServiceImpl(client: ApiClient(Dio())));
  final sharedPrefs = await SharedPreferences.getInstance();
  final saveDestinationService = SaveDestinationService(storage: sharedPrefs);
  locator.registerSingleton<SaveDestinationInterface>(saveDestinationService);
  locator.registerSingleton<RecommendationInterface>(RecommendationImpl());
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
}
