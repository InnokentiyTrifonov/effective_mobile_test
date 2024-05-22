import 'package:effective_mobile_test/app/service_locator.dart';
import 'package:effective_mobile_test/domain/blocs/direct_flights/direct_flights_bloc.dart';
import 'package:effective_mobile_test/domain/blocs/local_history/keys.dart';
import 'package:effective_mobile_test/domain/blocs/local_history/local_history_bloc.dart';
import 'package:effective_mobile_test/domain/blocs/recommendation/recommendation_bloc.dart';
import 'package:effective_mobile_test/domain/navigator/navigation_service.dart';
import 'package:effective_mobile_test/presentation/components/custom_text_field.dart';
import 'package:effective_mobile_test/presentation/screens/tickets_on_airplane/tickets_on_airplane.dart';
import 'package:effective_mobile_test/theme/color_resources.dart';
import 'package:effective_mobile_test/theme/drawable_resources.dart';
import 'package:effective_mobile_test/theme/string_resources.dart';
import 'package:effective_mobile_test/theme/style_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusResource.SIXTEEN),
        color: ColorResource.BOTTOM_SHEET_BG,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: PaddingResource.FOURTEEN),
        child: Column(
          children: [
            const SizedBox(height: regularSpace),
            Container(
              height: 5,
              width: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RadiusResource.TEN),
                color: ColorResource.GRAY_FIVE,
              ),
            ),
            const SizedBox(height: bigSpace),
            const _FragmentWithInputFields(),
            const SizedBox(height: bigSpace),
            const _Tips(),
            const SizedBox(height: bigSpace),
            const _Recommendations(),
          ],
        ),
      ),
    );
  }
}

class _FragmentWithInputFields extends StatefulWidget {
  const _FragmentWithInputFields();

  @override
  State<_FragmentWithInputFields> createState() => _FragmentWithInputFieldsState();
}

class _FragmentWithInputFieldsState extends State<_FragmentWithInputFields> {
  final TextEditingController _currentCityController = TextEditingController();
  final TextEditingController _desiredCityController = TextEditingController();

  void _onChangeCurrentCity() {
    if (_currentCityController.text.trim().isNotEmpty) {
      context
          .read<LocalHistoryBloc>()
          .add(SaveCity(key: LocalHistoryKeys.currentCity, city: _currentCityController.text.trim()));
      context.read<LocalHistoryBloc>().add(const GetSavedCities(
            currentCityKey: LocalHistoryKeys.currentCity,
            desiredCityKey: LocalHistoryKeys.desiredCity,
          ));
    } else {
      context.read<LocalHistoryBloc>().add(const RemoveCity(key: LocalHistoryKeys.currentCity));
      context.read<LocalHistoryBloc>().add(
            const GetSavedCities(
              currentCityKey: LocalHistoryKeys.currentCity,
              desiredCityKey: LocalHistoryKeys.desiredCity,
            ),
          );
    }
  }

  void _onChangeDesiredCity() {
    if (_desiredCityController.text.trim().isNotEmpty) {
      context
          .read<LocalHistoryBloc>()
          .add(SaveCity(key: LocalHistoryKeys.desiredCity, city: _desiredCityController.text.trim()));
      context.read<LocalHistoryBloc>().add(const GetSavedCities(
            currentCityKey: LocalHistoryKeys.currentCity,
            desiredCityKey: LocalHistoryKeys.desiredCity,
          ));
    } else {
      context.read<LocalHistoryBloc>().add(const RemoveCity(key: LocalHistoryKeys.desiredCity));
      context.read<LocalHistoryBloc>().add(const GetSavedCities(
            currentCityKey: LocalHistoryKeys.currentCity,
            desiredCityKey: LocalHistoryKeys.desiredCity,
          ));
    }
  }

  @override
  void initState() {
    super.initState();
    _currentCityController.addListener(_onChangeCurrentCity);
    _desiredCityController.addListener(_onChangeDesiredCity);
  }

  @override
  void dispose() {
    super.dispose();
    _currentCityController.dispose();
    _desiredCityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalHistoryBloc, LocalHistoryState>(
      builder: (BuildContext blocContext, LocalHistoryState state) {
        if (state is CitiesSuccessfullyReceived) {
          state.currentCity != null ? _currentCityController.text = state.currentCity! : null;
          state.desiredCity != null ? _desiredCityController.text = state.desiredCity! : null;
        }

        return Container(
          height: heightOfFieldsForEnterCities,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RadiusResource.SIXTEEN),
            color: ColorResource.GRAY_THREE,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: PaddingResource.SIXTEEN),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    suffixIconPressed: () {
                      _currentCityController.clear();
                      context.read<LocalHistoryBloc>().add(const RemoveCity(key: LocalHistoryKeys.currentCity));
                      context.read<LocalHistoryBloc>().add(const GetSavedCities(
                            currentCityKey: LocalHistoryKeys.currentCity,
                            desiredCityKey: LocalHistoryKeys.desiredCity,
                          ));
                    },
                    suffixIcon: SvgPicture.asset(
                      IconResource.CLOSE,
                      fit: BoxFit.scaleDown,
                    ),
                    prefixIcon: SvgPicture.asset(IconResource.HOP_OFF_AIRPLANE),
                    hintText: StringResource.HINT_FROM_WHICH_CITY,
                    controller: _currentCityController,
                    textInputAction: TextInputAction.next,
                  ),
                  const Divider(
                    color: ColorResource.GRAY_FIVE,
                  ),
                  CustomTextField(
                    suffixIconPressed: () {
                      _desiredCityController.clear();
                      context.read<LocalHistoryBloc>().add(const RemoveCity(key: LocalHistoryKeys.desiredCity));
                      context.read<LocalHistoryBloc>().add(
                            const GetSavedCities(
                              currentCityKey: LocalHistoryKeys.currentCity,
                              desiredCityKey: LocalHistoryKeys.desiredCity,
                            ),
                          );
                    },
                    suffixIcon: SvgPicture.asset(
                      IconResource.CLOSE,
                      fit: BoxFit.scaleDown,
                    ),
                    prefixIcon: SvgPicture.asset(
                      IconResource.SEARCH,
                      width: 22,
                      height: 22,
                    ),
                    controller: _desiredCityController,
                    hintText: StringResource.HINT_TO_WHICH_CITY,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      if (_currentCityController.text.trim().isNotEmpty &&
                          _desiredCityController.text.trim().isNotEmpty) {
                        context.read<DirectFlightsBloc>().add(ReciveDirectFlights());
                        Navigator.pop(context);
                        locator<NavigationService>().pushTo("/TICKETS_CONFIGURATION");
                        return;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Tips extends StatelessWidget {
  const _Tips();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightOfFieldsForEnterCities,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TipsItem(
            color: ColorResource.GREEN,
            imagePath: IconResource.DIFFICULT_ROUTE,
            description: StringResource.DIFFICULT_ROUTE,
            onTap: () {
              Navigator.pop(context);
              locator<NavigationService>().pushTo("/DIFFICULT_ROUTE");
            },
          ),
          _TipsItem(
            color: ColorResource.BLUE,
            imagePath: IconResource.ANYWHERE,
            description: StringResource.ANYWHERE,
            onTap: () {
              Navigator.pop(context);
              locator<NavigationService>().pushTo("/ANYWHERE");
            },
          ),
          _TipsItem(
            color: ColorResource.DARK_BLUE,
            imagePath: IconResource.WEEKENDS,
            description: StringResource.WEEKENDS,
            onTap: () {
              Navigator.pop(context);
              locator<NavigationService>().pushTo("/WEEKENDS");
            },
          ),
          _TipsItem(
            color: ColorResource.RED,
            imagePath: IconResource.HOT_TICKETS,
            description: StringResource.HOT_TICKETS,
            onTap: () {
              Navigator.pop(context);
              locator<NavigationService>().pushTo("/HOT_TICKETS");
            },
          ),
        ],
      ),
    );
  }
}

class _TipsItem extends StatelessWidget {
  const _TipsItem({
    required this.color,
    required this.imagePath,
    required this.description,
    this.onTap,
  });
  final Color color;
  final String imagePath;
  final String description;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RadiusResource.EIGHT),
                color: color,
              ),
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  imagePath,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                description,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Recommendations extends StatelessWidget {
  const _Recommendations();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalHistoryBloc, LocalHistoryState>(
      builder: (BuildContext localHistoryContext, LocalHistoryState localHistoryState) {
        String? currentCity;

        if (localHistoryState is CitiesSuccessfullyReceived) {
          currentCity = localHistoryState.currentCity;
        }

        return UnconstrainedBox(
          constrainedAxis: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.all(smallSpace),
            decoration: BoxDecoration(
              color: ColorResource.GRAY_THREE,
              borderRadius: BorderRadius.circular(RadiusResource.SIXTEEN),
            ),
            child: BlocBuilder<RecommendationBloc, RecommendationState>(
              builder: (context, recommendationsState) {
                if (recommendationsState is RecommendationSuccessfulReceived) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...recommendationsState.recommendations.map(
                        (item) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              if (currentCity != null) {
                                context.read<LocalHistoryBloc>().add(SaveCity(
                                      key: LocalHistoryKeys.desiredCity,
                                      city: item.city,
                                    ));
                                context.read<LocalHistoryBloc>().add(const GetSavedCities(
                                      currentCityKey: LocalHistoryKeys.currentCity,
                                      desiredCityKey: LocalHistoryKeys.desiredCity,
                                    ));
                                context.read<DirectFlightsBloc>().add(ReciveDirectFlights());
                                Navigator.pop(context);
                                locator<NavigationService>().pushTo("/TICKETS_CONFIGURATION");
                                return;
                              }
                              context.read<LocalHistoryBloc>().add(SaveCity(
                                    key: LocalHistoryKeys.desiredCity,
                                    city: item.city,
                                  ));
                              context.read<LocalHistoryBloc>().add(const GetSavedCities(
                                    currentCityKey: LocalHistoryKeys.currentCity,
                                    desiredCityKey: LocalHistoryKeys.desiredCity,
                                  ));

                              return;
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(RadiusResource.EIGHT),
                                      child: Image.asset(
                                        item.image,
                                        fit: BoxFit.fill,
                                        width: 45,
                                        height: 45,
                                      ),
                                    ),
                                    const SizedBox(width: PaddingResource.FOURTEEN),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          item.city,
                                          style: const TextStyle(
                                            fontFamily: FontFamilyResource.MEDIUM,
                                            color: ColorResource.WHITE,
                                            fontWeight: FontWeight.w600,
                                            fontSize: FontSizeResource.SIXTEEN,
                                          ),
                                        ),
                                        const Text(
                                          StringResource.POPULAR_DESTINATION,
                                          style: TextStyle(
                                            fontFamily: FontFamilyResource.SEMIBOLD,
                                            color: ColorResource.GRAY_FIVE,
                                            fontWeight: FontWeight.w400,
                                            fontSize: FontSizeResource.FOURTEEN,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                return const Center(
                  child: Text(StringResource.NO_RECOMMENDATIONS),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
