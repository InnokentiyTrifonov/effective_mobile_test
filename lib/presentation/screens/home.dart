import 'package:effective_mobile_test/core/navigation.dart';
import 'package:effective_mobile_test/core/theme/color_resources.dart';
import 'package:effective_mobile_test/core/theme/drawable_resources.dart';
import 'package:effective_mobile_test/core/theme/string_resources.dart';
import 'package:effective_mobile_test/core/theme/style_resources.dart';
import 'package:effective_mobile_test/presentation/screens/account.dart';
import 'package:effective_mobile_test/presentation/screens/brief.dart';
import 'package:effective_mobile_test/presentation/screens/hotels.dart';
import 'package:effective_mobile_test/presentation/screens/subscribes.dart';
import 'package:effective_mobile_test/presentation/screens/tickets_on_airplane/all_tickets.dart';
import 'package:effective_mobile_test/presentation/screens/tickets_on_airplane/ticket_configuration.dart';
import 'package:effective_mobile_test/presentation/screens/tickets_on_airplane/tickets_on_airplane.dart';
import 'package:effective_mobile_test/presentation/screens/tickets_on_airplane/tips_screens/anywhere.dart';
import 'package:effective_mobile_test/presentation/screens/tickets_on_airplane/tips_screens/difficult_route.dart';
import 'package:effective_mobile_test/presentation/screens/tickets_on_airplane/tips_screens/hot_tickets.dart';
import 'package:effective_mobile_test/presentation/screens/tickets_on_airplane/tips_screens/weekends.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: PaddingResource.fourTeen),
        child: IndexedStack(
          index: _currentIndex,
          children: const [
            TicketsOnAirPlaneNavigator(),
            Hotels(),
            Brief(),
            Subscribes(),
            Account(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorResource.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: ColorResource.blue,
        unselectedItemColor: ColorResource.graySix,
        selectedFontSize: FontSizeResource.ten,
        unselectedFontSize: FontSizeResource.ten,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (_currentIndex != index) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            label: StringResource.airTickets,
            icon: SvgPicture.asset(IconResource.airPlane),
            activeIcon: SvgPicture.asset(
              IconResource.airPlane,
              colorFilter: const ColorFilter.mode(ColorResource.blue, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: StringResource.hotels,
            icon: SvgPicture.asset(IconResource.bed),
            activeIcon: SvgPicture.asset(
              IconResource.bed,
              colorFilter: const ColorFilter.mode(ColorResource.blue, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: StringResource.brief,
            icon: SvgPicture.asset(IconResource.pin),
            activeIcon: SvgPicture.asset(
              IconResource.pin,
              colorFilter: const ColorFilter.mode(ColorResource.blue, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: StringResource.subscribes,
            icon: SvgPicture.asset(IconResource.bell),
            activeIcon: SvgPicture.asset(
              IconResource.bell,
              colorFilter: const ColorFilter.mode(ColorResource.blue, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: StringResource.account,
            icon: SvgPicture.asset(IconResource.account),
            activeIcon: SvgPicture.asset(
              IconResource.account,
              colorFilter: const ColorFilter.mode(ColorResource.blue, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketsOnAirPlaneNavigator extends StatefulWidget {
  const TicketsOnAirPlaneNavigator({super.key});

  @override
  State<TicketsOnAirPlaneNavigator> createState() => _TicketsOnAirPlaneNavigatorState();
}

class _TicketsOnAirPlaneNavigatorState extends State<TicketsOnAirPlaneNavigator> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (Navigation.canPop()) {
          Navigation.goBack();
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: Navigator(
        key: Navigation.navigationKey,
        initialRoute: "/",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/":
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const TicketsOnAirPlane(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              );
            case "/TICKETS_CONFIGURATION":
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const TicketConfiguration(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              );
            case "/DIFFICULT_ROUTE":
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const DifficultRoute(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              );
            case "/ANYWHERE":
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const Anywhere(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              );
            case "/WEEKENDS":
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const Weekends(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              );
            case "/HOT_TICKETS":
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const HotTickets(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              );
            case "/ALL_TICKETS":
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const AllTickets(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              );

            default:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const Scaffold(body: Center(child: Text("Page not found"))),
              );
          }
        },
      ),
    );
  }
}
