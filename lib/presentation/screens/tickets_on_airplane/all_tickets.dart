import 'dart:io';

import 'package:effective_mobile_test/app/service_locator.dart';
import 'package:effective_mobile_test/domain/blocs/local_history/local_history_bloc.dart';
import 'package:effective_mobile_test/domain/blocs/recive_all_tickets/recive_all_tickets_bloc.dart';
import 'package:effective_mobile_test/domain/models/dates.dart';
import 'package:effective_mobile_test/domain/navigator/navigation_service.dart';
import 'package:effective_mobile_test/theme/color_resources.dart';
import 'package:effective_mobile_test/theme/drawable_resources.dart';
import 'package:effective_mobile_test/theme/string_resources.dart';
import 'package:effective_mobile_test/theme/style_resources.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const bigSpace = 30.0;
const regularSpace = 20.0;
const littleSpace = 14.0;
const smallSpace = 8.0;

class AllTickets extends StatelessWidget {
  const AllTickets({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          SizedBox(height: regularSpace),
          _RoutesTable(),
          SizedBox(height: bigSpace),
          _FragmentWithTickets(),
          SizedBox(height: bigSpace),
        ],
      ),
    );
  }
}

class _RoutesTable extends StatefulWidget {
  const _RoutesTable();

  @override
  State<_RoutesTable> createState() => _RoutesTableState();
}

class _RoutesTableState extends State<_RoutesTable> {
  String description = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    final locale = Platform.localeName;

    final departureDate =
        '${DateFormat.d(locale).format(Dates().departureDate ?? DateTime.now())} ${DateFormat.LLL(locale).format(Dates().departureDate ?? DateTime.now())}';
    String reverseDepartureDate = '';

    if (Dates().reverseDepartureDate != null) {
      reverseDepartureDate =
          ' - ${DateFormat.d(locale).format(Dates().reverseDepartureDate!)} ${DateFormat.LLL(locale).format(Dates().reverseDepartureDate!)}';
    }
    description = departureDate + reverseDepartureDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalHistoryBloc, LocalHistoryState>(
      builder: (context, state) {
        String currentCity = '';
        String desiredCity = '';
        if (state is CitiesSuccessfullyReceived) {
          currentCity = state.currentCity ?? '';
          desiredCity = state.desiredCity ?? '';
        }

        return Container(
          color: ColorResource.BOTTOM_SHEET_BG,
          padding: const EdgeInsets.all(PaddingResource.FOURTEEN),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => locator<NavigationService>().goBack(),
                child: SvgPicture.asset(
                  IconResource.BACK,
                  colorFilter: const ColorFilter.mode(ColorResource.BLUE, BlendMode.srcIn),
                ),
              ),
              const SizedBox(width: littleSpace),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$currentCity-$desiredCity',
                      style: const TextStyle(
                        fontFamily: FontFamilyResource.MEDIUM,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$description, 1 пассажир',
                      style: const TextStyle(
                        fontFamily: FontFamilyResource.REGULAR,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: ColorResource.GRAY_SIX,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FragmentWithTickets extends StatelessWidget {
  const _FragmentWithTickets();

  String formatFlightDuration(Duration duration) {
    int totalMinutes = duration.inMinutes;
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    if (hours == 0) {
      return '$minutesмин';
    } else if (minutes == 0) {
      return '$hoursч';
    } else {
      return '$hoursч $minutesмин';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiveAllTicketsBloc, ReceiveAllTicketsState>(
      builder: (context, state) {
        if (state is TicketsReceivedSuccesful) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.tickets.length,
              itemBuilder: (context, index) {
                final ticket = state.tickets[index];
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: PaddingResource.EIGHT),
                      child: Container(
                        width: double.maxFinite,
                        height: 100,
                        padding: const EdgeInsets.symmetric(horizontal: PaddingResource.FOURTEEN),
                        decoration: BoxDecoration(
                          color: ColorResource.DIRECTION_FLIGHT_BG,
                          borderRadius: BorderRadius.circular(
                            RadiusResource.EIGHT,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${ticket.price} ₽',
                              style: const TextStyle(
                                fontFamily: FontFamilyResource.REGULAR,
                                fontSize: FontSizeResource.TWENTY_TWO,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: PaddingResource.EIGHT),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 24,
                                  width: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(RadiusResource.SIXTEEN),
                                      color: ColorResource.RED),
                                ),
                                const SizedBox(width: PaddingResource.EIGHT),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      DateFormat.Hm().format(ticket.arrivalDate),
                                      style: const TextStyle(
                                        fontFamily: FontFamilyResource.REGULAR,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    Text(
                                      ticket.departureAirport,
                                      style: const TextStyle(
                                        fontFamily: FontFamilyResource.REGULAR,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(' - '),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      DateFormat.Hm().format(ticket.arrivalDate),
                                      style: const TextStyle(
                                        fontFamily: FontFamilyResource.REGULAR,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    Text(
                                      ticket.departureAirport,
                                      style: const TextStyle(
                                        fontFamily: FontFamilyResource.REGULAR,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text('${formatFlightDuration(ticket.flightTime)}${StringResource.HOUR_IN_ROAD}'),
                                if (ticket.hasTransfer) const Text(StringResource.HAS_TRANSFER),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (ticket.badge != null && ticket.badge!.isNotEmpty)
                      UnconstrainedBox(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorResource.BLUE,
                            borderRadius: BorderRadius.circular(RadiusResource.FIFTY),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            child: Text(
                              ticket.badge!,
                              style: const TextStyle(
                                fontFamily: FontFamilyResource.REGULAR,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {
        if (state is TicketsReceivedFailed) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text(StringResource.TICKETS_NO_AVAILABLE),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(StringResource.OK),
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
