import 'package:effective_mobile_test/domain/blocs/direct_flights/direct_flights_bloc.dart';
import 'package:effective_mobile_test/domain/blocs/local_history/local_history_bloc.dart';
import 'package:effective_mobile_test/domain/blocs/musical_directions/musical_directions_bloc.dart';
import 'package:effective_mobile_test/domain/blocs/recommendation/recommendation_bloc.dart';
import 'package:effective_mobile_test/domain/models/musical_direction.dart';
import 'package:effective_mobile_test/presentation/components/custom_button.dart';
import 'package:effective_mobile_test/theme/color_resources.dart';
import 'package:effective_mobile_test/theme/drawable_resources.dart';
import 'package:effective_mobile_test/theme/string_resources.dart';
import 'package:effective_mobile_test/theme/style_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom_bottom_sheet/custom_bottom_sheet.dart';

const bigSpace = 30.0;
const regularSpace = 20.0;
const smallSpace = 8.0;
const heightOfFieldsForEnterCities = 100.0;

class TicketsOnAirPlane extends StatelessWidget {
  const TicketsOnAirPlane({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          const SizedBox(height: bigSpace),
          const _MainTitle(),
          const SizedBox(height: bigSpace),
          BlocBuilder<LocalHistoryBloc, LocalHistoryState>(
            builder: (BuildContext context, LocalHistoryState state) {
              String? currentCity;
              String? desiredCity;
              if (state is CitiesSuccessfullyReceived) {
                currentCity = state.currentCity;
                desiredCity = state.desiredCity;
              }
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    useRootNavigator: true,
                    isDismissible: false,
                    context: context,
                    builder: (context) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: BlocProvider.of<LocalHistoryBloc>(context)),
                          BlocProvider.value(
                              value: BlocProvider.of<RecommendationBloc>(context)..add(GetRecommendations())),
                          BlocProvider.value(value: BlocProvider.of<DirectFlightsBloc>(context)),
                        ],
                        child: const CustomBottomSheet(),
                      );
                    },
                  );
                },
                child: _FragmentWithEnteredCities(
                  currentCity: currentCity,
                  desiredCity: desiredCity,
                ),
              );
            },
          ),
          const SizedBox(height: bigSpace),
          BlocConsumer<MusicalDirectionsBloc, MusicalDirectionsState>(
            listener: (context, state) {
              if (state is MusicalDirectionsReceivedFailed) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(StringResource.MUSIC_TITLE_NOT_AVAILABLE),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(StringResource.OK),
                          ),
                        ],
                      );
                    });
              }
            },
            builder: (context, state) {
              if (state is MusicalDirectionsSuccessfulReceived) {
                return _MusicDirectionCarousel(musicalDirections: state.musicalDirections);
              } else {
                return const SizedBox();
              }
            },
          ),
          const SizedBox(height: bigSpace),
          CustomButton(
            onPressed: () {},
            text: StringResource.WATCH_ALL_TICKETS,
            color: ColorResource.GRAY_THREE,
          ),
        ],
      ),
    );
  }
}

class _MainTitle extends StatelessWidget {
  const _MainTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      textAlign: TextAlign.center,
      StringResource.MAIN_TITLE,
      style: TextStyle(
        fontFamily: FontFamilyResource.SEMIBOLD,
        fontSize: FontSizeResource.TWENTY_TWO,
        color: ColorResource.GRAY_SEVEN,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _FragmentWithEnteredCities extends StatelessWidget {
  const _FragmentWithEnteredCities({
    this.currentCity,
    this.desiredCity,
  });
  final String? currentCity;
  final String? desiredCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusResource.SIXTEEN),
        color: ColorResource.GRAY_THREE,
      ),
      child: Container(
        height: heightOfFieldsForEnterCities,
        margin: const EdgeInsets.all(PaddingResource.SIXTEEN),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusResource.SIXTEEN),
          color: ColorResource.GRAY_FOUR,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: PaddingResource.FOURTEEN),
          child: Row(
            children: [
              SvgPicture.asset(
                IconResource.SEARCH,
                colorFilter: const ColorFilter.mode(ColorResource.BLACK, BlendMode.srcIn),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: PaddingResource.FOURTEEN),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentCity ?? StringResource.HINT_FROM_WHICH_CITY,
                        style: TextStyle(
                          fontSize: FontSizeResource.SIXTEEN,
                          fontFamily: FontFamilyResource.REGULAR,
                          fontWeight: FontWeight.w600,
                          color: currentCity == null ? ColorResource.GRAY_SIX : ColorResource.WHITE,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Divider(
                          color: ColorResource.GRAY_FIVE,
                        ),
                      ),
                      Text(
                        desiredCity ?? StringResource.HINT_TO_WHICH_CITY,
                        style: TextStyle(
                          fontSize: FontSizeResource.SIXTEEN,
                          fontFamily: FontFamilyResource.REGULAR,
                          fontWeight: FontWeight.w600,
                          color: desiredCity == null ? ColorResource.GRAY_SIX : ColorResource.WHITE,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MusicTitle extends StatelessWidget {
  const _MusicTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      StringResource.MUSIC_TITLE,
      style: TextStyle(
        fontFamily: FontFamilyResource.SEMIBOLD,
        fontSize: FontSizeResource.TWENTY_TWO,
        color: ColorResource.WHITE,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _MusicDirectionCarousel extends StatelessWidget {
  const _MusicDirectionCarousel({
    required this.musicalDirections,
  });
  final List<MusicalDirection> musicalDirections;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _MusicTitle(),
        const SizedBox(height: regularSpace),
        SizedBox(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: musicalDirections.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: index == musicalDirections.length - 1 ? 0.0 : regularSpace),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// need default image to remove null
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(RadiusResource.SIXTEEN),
                        child: Image.asset(musicalDirections[index].image!),
                      ),
                    ),
                    const SizedBox(height: smallSpace),
                    Text(
                      musicalDirections[index].musicalGroupName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeResource.SIXTEEN,
                        fontFamily: FontFamilyResource.MEDIUM,
                      ),
                    ),
                    const SizedBox(height: smallSpace),
                    Text(
                      musicalDirections[index].city,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: FontSizeResource.FOURTEEN,
                        fontFamily: FontFamilyResource.SEMIBOLD,
                      ),
                    ),
                    const SizedBox(height: smallSpace),
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconResource.AIRPLANE,
                          colorFilter: const ColorFilter.mode(ColorResource.GRAY_SIX, BlendMode.srcIn),
                        ),
                        Text(
                          'от ${musicalDirections[index].price} ₽',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: FontSizeResource.FOURTEEN,
                            fontFamily: FontFamilyResource.SEMIBOLD,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
