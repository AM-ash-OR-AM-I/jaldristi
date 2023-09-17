import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/report_provider.dart';
import 'global_navigator.dart';
import 'screen_names.dart';

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
