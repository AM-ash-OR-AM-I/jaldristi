import 'package:flutter/material.dart';

import '../screens/camera_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import 'screen_names.dart';

getRoute(Screens screenName) {
  switch (screenName) {
    case Screens.loginScreen:
      return (_) => const LoginScreen();
    case Screens.homeScreen:
      return (_) => const HomeScreen();
    case Screens.cameraScreen:
      return (_) => const CameraScreen();
    case Screens.reportScreen:
      return (_) => const CameraScreen();
    default:
      throw Exception("Invalid route");
  }
}

final routes = Map<String, Widget Function(BuildContext)>.fromEntries(
  Screens.values.map(
    (screenName) => MapEntry(
      screenName.route,
      getRoute(screenName),
    ),
  ),
);
