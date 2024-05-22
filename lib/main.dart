import 'package:effective_mobile_test/app/app.dart';
import 'package:effective_mobile_test/app/service_locator.dart';
import 'package:effective_mobile_test/domain/blocs/direct_flights/direct_flights_bloc.dart';
import 'package:effective_mobile_test/domain/blocs/local_history/keys.dart';
import 'package:effective_mobile_test/domain/blocs/local_history/local_history_bloc.dart';
import 'package:effective_mobile_test/domain/blocs/musical_directions/musical_directions_bloc.dart';
import 'package:effective_mobile_test/domain/blocs/recive_all_tickets/recive_all_tickets_bloc.dart';
import 'package:effective_mobile_test/domain/blocs/recommendation/recommendation_bloc.dart';
import 'package:effective_mobile_test/domain/recommendation_interface.dart';
import 'package:effective_mobile_test/domain/save_destination_interface.dart';
import 'package:effective_mobile_test/domain/api_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MusicalDirectionsBloc>(
          create: (BuildContext context) =>
              MusicalDirectionsBloc(contractImpl: locator.get<ApiServiceInterface>())..add(LoadMusicalDirections()),
        ),
        BlocProvider<LocalHistoryBloc>(
          create: (BuildContext context) => LocalHistoryBloc(contractImpl: locator.get<SaveDestinationInterface>())
            ..add(const GetSavedCities(
              currentCityKey: LocalHistoryKeys.currentCity,
              desiredCityKey: LocalHistoryKeys.desiredCity,
            )),
        ),
        BlocProvider(
            create: (BuildContext context) => DirectFlightsBloc(contractImpl: locator.get<ApiServiceInterface>())),
        BlocProvider(
            create: (BuildContext context) => ReceiveAllTicketsBloc(contract: locator.get<ApiServiceInterface>())),
        BlocProvider(
            create: (BuildContext context) => RecommendationBloc(contractImpl: locator.get<RecommendationInterface>())),
      ],
      child: const App(),
    ),
  );
}
