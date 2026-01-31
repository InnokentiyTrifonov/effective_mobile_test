import 'package:effective_mobile_test/core/navigation.dart';
import 'package:effective_mobile_test/core/theme/color_resources.dart';
import 'package:effective_mobile_test/core/theme/drawable_resources.dart';
import 'package:effective_mobile_test/core/theme/string_resources.dart';
import 'package:effective_mobile_test/core/theme/style_resources.dart';
import 'package:effective_mobile_test/presentation/blocs/direct_flights/direct_flights_bloc.dart';
import 'package:effective_mobile_test/presentation/blocs/local_history/local_history_bloc.dart';
import 'package:effective_mobile_test/presentation/blocs/recommendation/recommendation_bloc.dart';
import 'package:effective_mobile_test/presentation/screens/tickets_on_airplane/tickets_on_airplane.dart';
import 'package:effective_mobile_test/presentation/widgets/custom_text_field.dart';
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
        borderRadius: BorderRadius.circular(RadiusResource.sixTeen),
        color: ColorResource.bottomSheetBg,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: PaddingResource.fourTeen),
        child: Column(
          children: [
            const SizedBox(height: regularSpace),
            Container(
              height: 5,
              width: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RadiusResource.ten),
                color: ColorResource.grayFive,
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
      context.read<LocalHistoryBloc>().add(SaveCurrentCity(_currentCityController.text.trim()));
      context.read<LocalHistoryBloc>().add(GetSavedCities());
    } else {
      context.read<LocalHistoryBloc>().add(RemoveCurrentCity());
      context.read<LocalHistoryBloc>().add(GetSavedCities());
    }
  }

  void _onChangeDesiredCity() {
    if (_desiredCityController.text.trim().isNotEmpty) {
      context.read<LocalHistoryBloc>().add(SaveDesiredCity(_desiredCityController.text.trim()));
      context.read<LocalHistoryBloc>().add(GetSavedCities());
    } else {
      context.read<LocalHistoryBloc>().add(RemoveDesiredCity());
      context.read<LocalHistoryBloc>().add(GetSavedCities());
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
            borderRadius: BorderRadius.circular(RadiusResource.sixTeen),
            color: ColorResource.grayThree,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: PaddingResource.sixTeen),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    suffixIconPressed: () {
                      _currentCityController.clear();
                      context.read<LocalHistoryBloc>().add(RemoveCurrentCity());
                      context.read<LocalHistoryBloc>().add(GetSavedCities());
                    },
                    suffixIcon: SvgPicture.asset(IconResource.close, fit: BoxFit.scaleDown),
                    prefixIcon: SvgPicture.asset(IconResource.hopOffAirplane),
                    hintText: StringResource.hintFromWhichCity,
                    controller: _currentCityController,
                    textInputAction: TextInputAction.next,
                  ),
                  const Divider(color: ColorResource.grayFive),
                  CustomTextField(
                    suffixIconPressed: () {
                      _desiredCityController.clear();
                      context.read<LocalHistoryBloc>().add(RemoveDesiredCity());
                      context.read<LocalHistoryBloc>().add(GetSavedCities());
                    },
                    suffixIcon: SvgPicture.asset(IconResource.close, fit: BoxFit.scaleDown),
                    prefixIcon: SvgPicture.asset(IconResource.search, width: 22, height: 22),
                    controller: _desiredCityController,
                    hintText: StringResource.hintToWhichCity,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      if (_currentCityController.text.trim().isNotEmpty &&
                          _desiredCityController.text.trim().isNotEmpty) {
                        context.read<DirectFlightsBloc>().add(ReciveDirectFlights());
                        Navigator.pop(context);
                        Navigation.pushTo("/TICKETS_CONFIGURATION");
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
            color: ColorResource.green,
            imagePath: IconResource.difficultRoute,
            description: StringResource.difficultRoute,
            onTap: () {
              Navigator.pop(context);
              Navigation.pushTo("/DIFFICULT_ROUTE");
            },
          ),
          _TipsItem(
            color: ColorResource.blue,
            imagePath: IconResource.anywhere,
            description: StringResource.anyWhere,
            onTap: () {
              Navigator.pop(context);
              Navigation.pushTo("/ANYWHERE");
            },
          ),
          _TipsItem(
            color: ColorResource.darkBlue,
            imagePath: IconResource.weekends,
            description: StringResource.weekends,
            onTap: () {
              Navigator.pop(context);
              Navigation.pushTo("/WEEKENDS");
            },
          ),
          _TipsItem(
            color: ColorResource.red,
            imagePath: IconResource.hotTickets,
            description: StringResource.hotTickets,
            onTap: () {
              Navigator.pop(context);
              Navigation.pushTo("/HOT_TICKETS");
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
                borderRadius: BorderRadius.circular(RadiusResource.eight),
                color: color,
              ),
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(imagePath, fit: BoxFit.scaleDown),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(description, textAlign: TextAlign.center),
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
              color: ColorResource.grayThree,
              borderRadius: BorderRadius.circular(RadiusResource.sixTeen),
            ),
            child: BlocBuilder<RecommendationBloc, RecommendationState>(
              builder: (context, recommendationsState) {
                if (recommendationsState is RecommendationSuccessfulReceived) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...recommendationsState.recommendations.map((item) {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if (currentCity != null) {
                              context.read<LocalHistoryBloc>().add(SaveDesiredCity(item.city));
                              context.read<LocalHistoryBloc>().add(GetSavedCities());
                              context.read<DirectFlightsBloc>().add(ReciveDirectFlights());
                              Navigator.pop(context);
                              Navigation.pushTo("/TICKETS_CONFIGURATION");
                              return;
                            }
                            context.read<LocalHistoryBloc>().add(SaveDesiredCity(item.city));
                            context.read<LocalHistoryBloc>().add(GetSavedCities());

                            return;
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(RadiusResource.eight),
                                    child: Image.asset(
                                      item.image,
                                      fit: BoxFit.fill,
                                      width: 45,
                                      height: 45,
                                    ),
                                  ),
                                  const SizedBox(width: PaddingResource.fourTeen),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        item.city,
                                        style: const TextStyle(
                                          fontFamily: FontFamilyResource.medium,
                                          color: ColorResource.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSizeResource.sixTeen,
                                        ),
                                      ),
                                      const Text(
                                        StringResource.popularDestination,
                                        style: TextStyle(
                                          fontFamily: FontFamilyResource.semiBold,
                                          color: ColorResource.grayFive,
                                          fontWeight: FontWeight.w400,
                                          fontSize: FontSizeResource.fourTeen,
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
                      }),
                    ],
                  );
                }
                return const Center(child: Text(StringResource.noRecommendations));
              },
            ),
          ),
        );
      },
    );
  }
}
