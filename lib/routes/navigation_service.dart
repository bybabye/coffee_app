import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setupLocator() {
    locator.registerLazySingleton(() => NavigationService());
  }

  void navigateToPage(Widget page) {
    navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => page));
  }

  void goPage(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  void goToPage(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goToPageAndRemoveAllRoutes(Widget page) {
    navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => page), (route) => false);
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
