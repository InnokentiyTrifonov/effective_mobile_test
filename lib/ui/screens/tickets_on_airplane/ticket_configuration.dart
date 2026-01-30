import 'dart:io';

import 'package:effective_mobile_test/blocs/direct_flights/direct_flights_bloc.dart';
import 'package:effective_mobile_test/blocs/local_history/local_history_bloc.dart';
import 'package:effective_mobile_test/blocs/receive_all_tickets/recive_all_tickets_bloc.dart';
import 'package:effective_mobile_test/core/navigation.dart';
import 'package:effective_mobile_test/core/theme/color_resources.dart';
import 'package:effective_mobile_test/core/theme/drawable_resources.dart';
import 'package:effective_mobile_test/core/theme/string_resources.dart';
import 'package:effective_mobile_test/core/theme/style_resources.dart';
import 'package:effective_mobile_test/models/dates.dart';
import 'package:effective_mobile_test/ui/widgets/custom_button.dart';
import 'package:effective_mobile_test/ui/widgets/custom_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const bigSpace = 30.0;
const regularSpace = 20.0;
const littleSpace = 14.0;
const smallSpace = 8.0;
const heightOfFieldsForEnterCities = 100.0;

class TicketConfiguration extends StatelessWidget {
  const TicketConfiguration({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          const SizedBox(height: regularSpace),
          const _SelectedCities(),
          const SizedBox(height: regularSpace),
          const _ButtonCarousel(),
          const SizedBox(height: regularSpace),
          const _DirectFlights(),
          const SizedBox(height: regularSpace),
          CustomButton(
            color: ColorResource.blue,
            onPressed: () {
              context.read<ReceiveAllTicketsBloc>().add(ReceiveTickets());
              Navigation.pushTo("/ALL_TICKETS");
            },
            text: StringResource.seeAllTickets,
          ),
          const SizedBox(height: regularSpace),
          const _SubsctibeOnPrice(),
          const SizedBox(height: regularSpace),
        ],
      ),
    );
  }
}

class _SelectedCities extends StatelessWidget {
  const _SelectedCities();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalHistoryBloc, LocalHistoryState>(
      builder: (context, state) {
        String? currentCity;
        String? desiredCity;
        if (state is CitiesSuccessfullyReceived) {
          currentCity = state.currentCity;
          desiredCity = state.desiredCity;
        }

        return Container(
          height: heightOfFieldsForEnterCities,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RadiusResource.sixTeen),
            color: ColorResource.grayFour,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: PaddingResource.fourTeen),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigation.goBack(),
                  child: SvgPicture.asset(
                    IconResource.back,
                    colorFilter: const ColorFilter.mode(ColorResource.white, BlendMode.srcIn),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: PaddingResource.fourTeen),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              currentCity ?? StringResource.hintFromWhichCity,
                              style: TextStyle(
                                fontSize: FontSizeResource.sixTeen,
                                fontFamily: FontFamilyResource.regular,
                                fontWeight: FontWeight.w600,
                                color: currentCity == null
                                    ? ColorResource.graySix
                                    : ColorResource.white,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => context.read<LocalHistoryBloc>().add(SwitchCities()),
                              child: SvgPicture.asset(
                                IconResource.reverse,
                                fit: BoxFit.scaleDown,
                                height: 13,
                                width: 13,
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Divider(color: ColorResource.grayFive),
                        ),
                        Row(
                          children: [
                            Text(
                              desiredCity ?? StringResource.hintToWhichCity,
                              style: TextStyle(
                                fontSize: FontSizeResource.sixTeen,
                                fontFamily: FontFamilyResource.regular,
                                fontWeight: FontWeight.w600,
                                color: desiredCity == null
                                    ? ColorResource.graySix
                                    : ColorResource.white,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                context.read<LocalHistoryBloc>().add(RemoveDesiredCity());
                                context.read<LocalHistoryBloc>().add(GetSavedCities());
                                Navigation.goBack();
                              },
                              child: SvgPicture.asset(IconResource.close, fit: BoxFit.scaleDown),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ButtonCarousel extends StatelessWidget {
  const _ButtonCarousel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          _DateOfReverseDepartureButton(
            onSelect: (selectedDate) {
              final dates = Dates();
              dates.reverseDepartureDate = selectedDate;
            },
          ),
          const SizedBox(width: smallSpace),
          _DepartureDateButton(
            onSelect: (selectedDate) {
              final dates = Dates();
              dates.departureDate = selectedDate;
            },
          ),
          const SizedBox(width: smallSpace),
          const _NumberOfPassangers(),
          const SizedBox(width: smallSpace),
          const _Filters(),
        ],
      ),
    );
  }
}

class _DepartureDateButton extends StatefulWidget {
  final Function(DateTime?) onSelect;
  const _DepartureDateButton({required this.onSelect});

  @override
  State<_DepartureDateButton> createState() => _DepartureDateButtonState();
}

class _DepartureDateButtonState extends State<_DepartureDateButton> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    if (Platform.isIOS) {
      await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            color: ColorResource.grayTwo,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              onDateTimeChanged: (dateTime) {
                setState(() {
                  selectedDate = dateTime;
                });
              },
            ),
          );
        },
      );
      widget.onSelect(selectedDate);
      return;
    }

    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDate: selectedDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onSelect(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    final locale = Platform.localeName;
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusResource.fifty),
          color: ColorResource.grayThree,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${DateFormat.d(locale).format(selectedDate)} ${DateFormat.LLL(locale).format(selectedDate)}, ",
              style: const TextStyle(
                fontFamily: FontFamilyResource.regular,
                fontSize: FontSizeResource.fourTeen,
              ),
            ),
            Text(
              DateFormat.E(locale).format(selectedDate),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: FontFamilyResource.regular,
                fontSize: FontSizeResource.fourTeen,
                color: ColorResource.graySix,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateOfReverseDepartureButton extends StatefulWidget {
  final Function(DateTime?) onSelect;
  const _DateOfReverseDepartureButton({required this.onSelect});

  @override
  State<_DateOfReverseDepartureButton> createState() => _DateOfReverseDepartureButtonState();
}

class _DateOfReverseDepartureButtonState extends State<_DateOfReverseDepartureButton> {
  String? locale;
  String? dayOfMonth;
  String? dayOfWeek;
  String? month;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    locale = Platform.localeName;
    Dates().reverseDepartureDate = null;
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    if (Platform.isIOS) {
      await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (context) {
          return Container(
            color: ColorResource.grayTwo,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              onDateTimeChanged: (dateTime) {
                setState(() {
                  selectedDate = dateTime;
                  month = DateFormat.LLL(locale).format(selectedDate);
                  dayOfMonth = DateFormat.d(locale).format(selectedDate);
                  dayOfWeek = DateFormat.E(locale).format(selectedDate);
                });
              },
            ),
          );
        },
      );
      widget.onSelect(selectedDate);
      return;
    }

    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDate: selectedDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        month = DateFormat.LLL(locale).format(selectedDate);
        dayOfMonth = DateFormat.d(locale).format(selectedDate);
        dayOfWeek = DateFormat.E(locale).format(selectedDate);
      });
      widget.onSelect(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusResource.fifty),
          color: ColorResource.grayThree,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (dayOfMonth == null && month == null)
                ? Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: SvgPicture.asset(
                      IconResource.plus,
                      fit: BoxFit.scaleDown,
                      height: 14,
                      width: 14,
                    ),
                  )
                : Text(
                    "$dayOfMonth $month, ",
                    style: const TextStyle(
                      fontFamily: FontFamilyResource.regular,
                      fontSize: FontSizeResource.fourTeen,
                    ),
                  ),
            Text(
              dayOfWeek ?? 'обратно',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: FontFamilyResource.regular,
                fontSize: FontSizeResource.fourTeen,
                color: dayOfWeek == null ? ColorResource.white : ColorResource.graySix,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberOfPassangers extends StatelessWidget {
  const _NumberOfPassangers();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusResource.fifty),
        color: ColorResource.grayThree,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: SvgPicture.asset(
              IconResource.plus,
              fit: BoxFit.scaleDown,
              height: 14,
              width: 14,
            ),
          ),
          const Text(
            '1, ${StringResource.econom}',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontFamily: FontFamilyResource.regular,
              fontSize: FontSizeResource.fourTeen,
              color: ColorResource.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusResource.fifty),
        color: ColorResource.grayThree,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: SvgPicture.asset(
              IconResource.settings,
              fit: BoxFit.scaleDown,
              height: 14,
              width: 14,
            ),
          ),
          const Text(
            ' фильтры',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontFamily: FontFamilyResource.regular,
              fontSize: FontSizeResource.fourTeen,
              color: ColorResource.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DirectFlights extends StatelessWidget {
  const _DirectFlights();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DirectFlightsBloc, DirectFlightsState>(
      builder: (context, state) {
        if (state is DirectFlightsSuccessfulReceived) {
          return Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingResource.sixTeen,
              vertical: PaddingResource.sixTeen,
            ),
            decoration: BoxDecoration(
              color: ColorResource.directionFlightBg,
              borderRadius: BorderRadius.circular(RadiusResource.sixTeen),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [
                    Text(
                      'Прямые рейсы',
                      style: TextStyle(
                        color: ColorResource.white,
                        fontFamily: FontFamilyResource.semiBold,
                        fontSize: FontSizeResource.twenty,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: regularSpace),
                ...state.directFlights.map(
                  (e) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                    child: Column(
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(RadiusResource.sixTeen),
                                color: e.colorOfAvatar,
                              ),
                            ),
                            const SizedBox(width: littleSpace),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        e.nameOfAirline,
                                        style: const TextStyle(
                                          fontFamily: FontFamilyResource.regular,
                                          fontSize: FontSizeResource.fourTeen,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${e.price.toString()} ₽',
                                        style: const TextStyle(
                                          fontFamily: FontFamilyResource.regular,
                                          fontSize: FontSizeResource.fourTeen,
                                          fontStyle: FontStyle.italic,
                                          color: ColorResource.darkBlue,
                                        ),
                                      ),
                                      const SizedBox(width: smallSpace),
                                      SvgPicture.asset(IconResource.rightArrow),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle: const StrutStyle(
                                            fontSize: 14,
                                            fontFamily: FontFamilyResource.semiBold,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          text: TextSpan(text: e.timeRange),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: smallSpace),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: smallSpace),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {
        if (state is DirectFlightsReceivedFailed) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text(StringResource.noRecommendations),
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
    );
  }
}

class _SubsctibeOnPrice extends StatefulWidget {
  const _SubsctibeOnPrice();

  @override
  State<_SubsctibeOnPrice> createState() => _SubsctibeOnPriceState();
}

class _SubsctibeOnPriceState extends State<_SubsctibeOnPrice> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: PaddingResource.sixTeen),
      height: 60,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: ColorResource.grayTwo,
        borderRadius: BorderRadius.circular(RadiusResource.eight),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            IconResource.bell,
            colorFilter: const ColorFilter.mode(ColorResource.blue, BlendMode.srcIn),
          ),
          const SizedBox(width: regularSpace),
          const Text(
            StringResource.subscribeOnPrice,
            style: TextStyle(
              fontSize: FontSizeResource.sixTeen,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamilyResource.regular,
            ),
          ),
          const Spacer(),
          CustomSwitcher(
            isSwitched: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
