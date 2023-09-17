import 'dart:convert';
import 'dart:developer';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jal_dristi_app/provider/api.dart';
import 'package:jal_dristi_app/provider/model/department.dart';

import '../common/native_api_calls.dart';

class ReportProvider extends ChangeNotifier {
  String path = "/home/ashucoder/Downloads/flood.jpg";
  String _category = 'Flood';

  String get category => _category;

  set category(String value) {
    _category = value;
    notifyListeners();
  }

  ReportProvider() {
    getDepartments();
  }

  final categories = [
    'Flood',
    'Water-Leakage',
    'Pipe-Rupture',
    'Water-Logging',
    'Drainage Issue',
    'Sewer Overflow',
    'Sewer Blockage',
    "Water supply issue",
    "Water scarcity",
  ];

  List<Department> departments = [];

  Department? _selectedDepartment;

  Department? get selectedDepartment => _selectedDepartment;

  set selectedDepartment(Department? value) {
    _selectedDepartment = value;
    notifyListeners();
  }

  getDepartments() async {
    List<Map<String, dynamic>> depts =
        jsonDecode(await Api.getDepartments()).cast<Map<String, dynamic>>();
    departments = depts.map((e) => Department.fromJson(e)).toList();
    _selectedDepartment = departments[0];
    notifyListeners();
  }

  String longitude = "";
  String latitude = "";

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    log("position = $position");
    longitude = position.longitude.toString();
    latitude = position.latitude.toString();
  }

  Future<String> reportIncident(
    String description,
  ) async {
    log("reportIncident called");

    // Get the current location
    await getCurrentPosition();
    final response = await Api.createIncident(
      description: description,
      category: category,
      departmentId: selectedDepartment!.id.toString(),
      imagePath: path,
      latitude: latitude,
      longitude: longitude,
    );
    log("response = $response");
    return response;
  }
}
