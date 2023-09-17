import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../provider/report_provider.dart';
import 'global_navigator.dart';
import 'screen_names.dart';

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;
  final context = navigatorKey.currentContext!;
  var scaffold = ScaffoldMessenger.of(context);

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    scaffold.showSnackBar(const SnackBar(
        content: Text(
      'Location services are disabled. Please enable the services',
    )));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      scaffold.showSnackBar(
        const SnackBar(
          content: Text('Location permissions are denied'),
        ),
      );
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    scaffold.showSnackBar(
      const SnackBar(
        content: Text(
          'Location permissions are permanently denied, we cannot request permissions.',
        ),
      ),
    );
    return false;
  }
  return true;
}

Future<void> chooseImageFromGallery() async {
  final context = navigatorKey.currentContext!;
  final navigator = Navigator.of(context);
  final model = context.read<ReportProvider>();
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    final String imagePath = result.files.single.path ?? "";
    model.path = imagePath;
    navigator.pushNamed(
      Screens.reportScreen.route,
    );
    log("imagePath =  $imagePath");
  }
}
