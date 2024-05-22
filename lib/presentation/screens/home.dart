import 'package:effective_mobile_test/app/service_locator.dart';
import 'package:effective_mobile_test/domain/navigator/navigation_service.dart';
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
import 'package:effective_mobile_test/theme/color_resources.dart';
import 'package:effective_mobile_test/theme/drawable_resources.dart';
import 'package:effective_mobile_test/theme/string_resources.dart';
import 'package:effective_mobile_test/theme/style_resources.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: PaddingResource.FOURTEEN),
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
        backgroundColor: ColorResource.BLACK,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: ColorResource.BLUE,
        unselectedItemColor: ColorResource.GRAY_SIX,
        selectedFontSize: FontSizeResource.TEN,
        unselectedFontSize: FontSizeResource.TEN,
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
            label: StringResource.AIR_TICKETS,
            icon: SvgPicture.asset(IconResource.AIRPLANE),
            activeIcon: SvgPicture.asset(
              IconResource.AIRPLANE,
              colorFilter: const ColorFilter.mode(ColorResource.BLUE, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: StringResource.HOTELS,
            icon: SvgPicture.asset(IconResource.BED),
            activeIcon: SvgPicture.asset(
              IconResource.BED,
              colorFilter: const ColorFilter.mode(ColorResource.BLUE, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: StringResource.BRIEF,
            icon: SvgPicture.asset(IconResource.PIN),
            activeIcon: SvgPicture.asset(
              IconResource.PIN,
              colorFilter: const ColorFilter.mode(ColorResource.BLUE, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: StringResource.SUBSCRIBES,
            icon: SvgPicture.asset(IconResource.BELL),
            activeIcon: SvgPicture.asset(
              IconResource.BELL,
              colorFilter: const ColorFilter.mode(ColorResource.BLUE, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            label: StringResource.ACCOUNT,
            icon: SvgPicture.asset(IconResource.ACCOUNT),
            activeIcon: SvgPicture.asset(
              IconResource.ACCOUNT,
              colorFilter: const ColorFilter.mode(ColorResource.BLUE, BlendMode.srcIn),
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
        if (locator<NavigationService>().canPop()) {
          locator<NavigationService>().goBack();
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: Navigator(
        key: locator<NavigationService>().navigationKey,
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
                  pageBuilder: (context, animation, secondaryAnimation) => const TicketConfiguration(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero);
            case "/DIFFICULT_ROUTE":
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const DifficultRoute(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero);
            case "/ANYWHERE":
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const Anywhere(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero);
            case "/WEEKENDS":
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const Weekends(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero);
            case "/HOT_TICKETS":
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const HotTickets(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero);
            case "/ALL_TICKETS":
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const AllTickets(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero);

            default:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const Scaffold(
                  body: Center(
                    child: Text("Page not found"),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
