import 'package:MeU/component/scan_component/scan_component_widget.dart';
import 'package:MeU/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class TabBarScreenWidget extends StatefulWidget {
  const TabBarScreenWidget({super.key});

  @override
  State<TabBarScreenWidget> createState() => _TabBarScreenWidgetState();
}

class _TabBarScreenWidgetState extends State<TabBarScreenWidget> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Colors.white,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property
    );
  }

  List<Widget> _buildScreens() {
    return [
      VcardScreenWidget(),
      SettingScreenWidget(),
      ScanComponentWidget(),
      DashboardScreenWidget(),
      DashboardScreenWidget()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: Color(0xFF1A4572),
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            // "/first": (final context) => const MainScreen2(),
            // "/second": (final context) => const MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: ("Profile"),
        activeColorPrimary: Color(0xFF1A4572),
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            // "/first": (final context) => const MainScreen2(),
            // "/second": (final context) => const MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.add_circled_solid,
          color: Color(0xFF1A4572),
          size: 64,
        ),
        activeColorPrimary: CupertinoColors.transparent,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            // "/first": (final context) => const MainScreen2(),
            // "/second": (final context) => const MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.chat_bubble),
        title: ("Settings"),
        activeColorPrimary: Color(0xFF1A4572),
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            // "/first": (final context) => const MainScreen2(),
            // "/second": (final context) => const MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.chart_bar),
        title: ("Settings"),
        activeColorPrimary: Color(0xFF1A4572),
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            // "/first": (final context) => const MainScreen2(),
            // "/second": (final context) => const MainScreen3(),
          },
        ),
      ),
    ];
  }
}
