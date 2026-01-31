import 'package:dio/dio.dart';
import 'package:effective_mobile_test/core/clients/api_client.dart';
import 'package:effective_mobile_test/core/theme/color_resources.dart';
import 'package:effective_mobile_test/data/api_service.dart';
import 'package:effective_mobile_test/data/db.dart';
import 'package:effective_mobile_test/data/recommendation_service.dart';
import 'package:effective_mobile_test/domain/interactors/get_all_tickets_interactor.dart';
import 'package:effective_mobile_test/domain/interactors/get_cities_interactor.dart';
import 'package:effective_mobile_test/domain/interactors/get_music_tickets_interactor.dart';
import 'package:effective_mobile_test/domain/interactors/get_recommendations_interactor.dart';
import 'package:effective_mobile_test/domain/interactors/get_ticket_offers_interactor.dart';
import 'package:effective_mobile_test/domain/interactors/remove_current_city_interactor.dart';
import 'package:effective_mobile_test/domain/interactors/remove_desired_city_interactor.dart';
import 'package:effective_mobile_test/domain/interactors/save_current_city_interactor.dart';
import 'package:effective_mobile_test/domain/interactors/save_desired_city_interactor.dart';
import 'package:effective_mobile_test/domain/interactors/switch_cities_interactor.dart';
import 'package:effective_mobile_test/presentation/blocs/direct_flights/direct_flights_bloc.dart';
import 'package:effective_mobile_test/presentation/blocs/local_history/local_history_bloc.dart';
import 'package:effective_mobile_test/presentation/blocs/musical_directions/musical_directions_bloc.dart';
import 'package:effective_mobile_test/presentation/blocs/receive_all_tickets/recive_all_tickets_bloc.dart';
import 'package:effective_mobile_test/presentation/blocs/recommendation/recommendation_bloc.dart';
import 'package:effective_mobile_test/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final apiService = ApiService(client: ApiClient(Dio(), baseUrl: dotenv.env['API_BASE_URL']!));
  final db = Db(storage: await SharedPreferences.getInstance());
  final recommendation = RecommendationService();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GetAllTicketsInteractor>(
          create: (context) => GetAllTicketsInteractor(apiService),
        ),
        RepositoryProvider<GetCitiesInteractor>(create: (context) => GetCitiesInteractor(db)),
        RepositoryProvider<SwitchCitiesInteractor>(create: (context) => SwitchCitiesInteractor(db)),
        RepositoryProvider<GetMusicTicketsInteractor>(
          create: (context) => GetMusicTicketsInteractor(apiService),
        ),
        RepositoryProvider<GetRecommendationsInteractor>(
          create: (context) => GetRecommendationsInteractor(recommendation),
        ),
        RepositoryProvider<GetTicketOffersInteractor>(
          create: (context) => GetTicketOffersInteractor(apiService),
        ),
        RepositoryProvider<RemoveCurrentCityInteractor>(
          create: (context) => RemoveCurrentCityInteractor(db),
        ),
        RepositoryProvider<RemoveDesiredCityInteractor>(
          create: (context) => RemoveDesiredCityInteractor(db),
        ),
        RepositoryProvider<SaveCurrentCityInteractor>(
          create: (context) => SaveCurrentCityInteractor(db),
        ),
        RepositoryProvider<SaveDesiredCityInteractor>(
          create: (context) => SaveDesiredCityInteractor(db),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MusicalDirectionsBloc>(
            create: (BuildContext context) =>
                MusicalDirectionsBloc(context.read<GetMusicTicketsInteractor>())
                  ..add(LoadMusicalDirections()),
          ),
          BlocProvider<LocalHistoryBloc>(
            create: (BuildContext context) => LocalHistoryBloc(
              context.read<GetCitiesInteractor>(),
              context.read<SwitchCitiesInteractor>(),
              context.read<SaveCurrentCityInteractor>(),
              context.read<SaveDesiredCityInteractor>(),
              context.read<RemoveCurrentCityInteractor>(),
              context.read<RemoveDesiredCityInteractor>(),
            )..add(GetSavedCities()),
          ),
          BlocProvider(
            create: (BuildContext context) =>
                DirectFlightsBloc(context.read<GetTicketOffersInteractor>()),
          ),
          BlocProvider(
            create: (BuildContext context) =>
                ReceiveAllTicketsBloc(context.read<GetAllTicketsInteractor>()),
          ),
          BlocProvider(
            create: (BuildContext context) =>
                RecommendationBloc(context.read<GetRecommendationsInteractor>()),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorResource.black,
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      home: const HomePage(),
    );
  }
}
