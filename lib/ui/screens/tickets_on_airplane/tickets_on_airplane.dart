import 'package:effective_mobile_test/blocs/direct_flights/direct_flights_bloc.dart';
import 'package:effective_mobile_test/blocs/local_history/local_history_bloc.dart';
import 'package:effective_mobile_test/blocs/musical_directions/musical_directions_bloc.dart';
import 'package:effective_mobile_test/blocs/recommendation/recommendation_bloc.dart';
import 'package:effective_mobile_test/core/theme/color_resources.dart';
import 'package:effective_mobile_test/core/theme/drawable_resources.dart';
import 'package:effective_mobile_test/core/theme/string_resources.dart';
import 'package:effective_mobile_test/core/theme/style_resources.dart';
import 'package:effective_mobile_test/models/musical_direction.dart';
import 'package:effective_mobile_test/ui/widgets/custom_button.dart';
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
                            value: BlocProvider.of<RecommendationBloc>(context)
                              ..add(GetRecommendations()),
                          ),
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
                      content: const Text(StringResource.musicTitleNotAvailable),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(StringResource.ok),
                        ),
                      ],
                    );
                  },
                );
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
            text: StringResource.watchAllTickets,
            color: ColorResource.grayThree,
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
      StringResource.mainTitle,
      style: TextStyle(
        fontFamily: FontFamilyResource.semiBold,
        fontSize: FontSizeResource.twentyTwo,
        color: ColorResource.graySeven,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _FragmentWithEnteredCities extends StatelessWidget {
  const _FragmentWithEnteredCities({this.currentCity, this.desiredCity});
  final String? currentCity;
  final String? desiredCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusResource.sixTeen),
        color: ColorResource.grayThree,
      ),
      child: Container(
        height: heightOfFieldsForEnterCities,
        margin: const EdgeInsets.all(PaddingResource.sixTeen),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusResource.sixTeen),
          color: ColorResource.grayFour,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: PaddingResource.fourTeen),
          child: Row(
            children: [
              SvgPicture.asset(
                IconResource.search,
                colorFilter: const ColorFilter.mode(ColorResource.black, BlendMode.srcIn),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: PaddingResource.fourTeen),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentCity ?? StringResource.hintFromWhichCity,
                        style: TextStyle(
                          fontSize: FontSizeResource.sixTeen,
                          fontFamily: FontFamilyResource.regular,
                          fontWeight: FontWeight.w600,
                          color: currentCity == null ? ColorResource.graySix : ColorResource.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Divider(color: ColorResource.grayFive),
                      ),
                      Text(
                        desiredCity ?? StringResource.hintToWhichCity,
                        style: TextStyle(
                          fontSize: FontSizeResource.sixTeen,
                          fontFamily: FontFamilyResource.regular,
                          fontWeight: FontWeight.w600,
                          color: desiredCity == null ? ColorResource.graySix : ColorResource.white,
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
      StringResource.musicTitle,
      style: TextStyle(
        fontFamily: FontFamilyResource.semiBold,
        fontSize: FontSizeResource.twentyTwo,
        color: ColorResource.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _MusicDirectionCarousel extends StatelessWidget {
  const _MusicDirectionCarousel({required this.musicalDirections});
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
                padding: EdgeInsets.only(
                  right: index == musicalDirections.length - 1 ? 0.0 : regularSpace,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// need default image to remove null
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(RadiusResource.sixTeen),
                        child: Image.asset(musicalDirections[index].image!),
                      ),
                    ),
                    const SizedBox(height: smallSpace),
                    Text(
                      musicalDirections[index].musicalGroupName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: FontSizeResource.sixTeen,
                        fontFamily: FontFamilyResource.medium,
                      ),
                    ),
                    const SizedBox(height: smallSpace),
                    Text(
                      musicalDirections[index].city,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: FontSizeResource.fourTeen,
                        fontFamily: FontFamilyResource.semiBold,
                      ),
                    ),
                    const SizedBox(height: smallSpace),
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconResource.airPlane,
                          colorFilter: const ColorFilter.mode(
                            ColorResource.graySix,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          'от ${musicalDirections[index].price} ₽',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: FontSizeResource.fourTeen,
                            fontFamily: FontFamilyResource.semiBold,
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
