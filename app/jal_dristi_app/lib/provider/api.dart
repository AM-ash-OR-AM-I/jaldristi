import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static const authority = "jaldristi.shubhendra.in";
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString("authToken");
  }

  static Future<void> setAuthToken(String authToken) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("authToken", authToken);
  }

  static Future<void> removeAuthToken() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove("authToken");
  }

  // Login to the app
  static Future<String> login({
    required username,
    required password,
  }) async {
    log("$username $password");
    try {
      final response = await post(
        Uri.https(authority, "/login"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: "username=$username&password=$password",
      );
      log("Login status = ${response.body}, responseCode = ${response.statusCode}");
      Map<String, dynamic> responseJson;
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          await setAuthToken(
              "${responseJson["token_type"]} ${responseJson["access_token"]}");
          return "Success";
        case 422:
          return jsonDecode(response.body)["detail"];
        case 401:
          return jsonDecode(response.body)["detail"].toString();
        default:
          return response.body;
      }
    } on Exception catch (e) {
      log(e.toString());
      return "Something went wrong, please check your internet connection.";
    }
  }

  // Create a new incident
  static Future<String> createIncident({
    required String imagePath,
    required String departmentId,
    required String description,
    required String category,
    String latitude = "27.717245",
    String longitude = "85.323959",
  }) async {
    final authToken = await getAuthToken();
    MultipartRequest request = MultipartRequest(
      "POST",
      Uri.https(authority, "/api/incidents/"),
    );
    final body = {
      "department_id": departmentId,
      "category": category,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
    };
    request.headers[HttpHeaders.acceptHeader] = "application/json";
    request.headers[HttpHeaders.contentTypeHeader] = "multipart/form-data";
    request.headers[HttpHeaders.authorizationHeader] = authToken!;
    request.fields.addAll(body);
    request.files.add(
      await MultipartFile.fromPath(
        "image",
        imagePath,
        filename: "file1.ppt",
      ),
    );

    try {
      final response = await request.send();
      log("Create incident status = ${response.statusCode}");
      switch (response.statusCode) {
        case 200:
          return "Success";
        case 422:
          return jsonDecode(await response.stream.bytesToString())["detail"]
              .toString();
        case 401:
          return jsonDecode(await response.stream.bytesToString())["detail"]
              .toString();
        default:
          return await response.stream.bytesToString();
      }
    } on Exception catch (e) {
      log(e.toString());
      return "Something went wrong, please check your internet connection.";
    }
  }

  // Get all the departments
  static Future<String> getDepartments() async {
    final authToken = await getAuthToken();
    try {
      final response = await get(
        Uri.https(authority, "/api/departments/"),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: authToken!,
        },
      );
      log("Get departments status = ${response.statusCode}");
      switch (response.statusCode) {
        case 200:
          return response.body;
        case 422:
          return jsonDecode(response.body)["detail"].toString();
        case 401:
          return jsonDecode(response.body)["detail"].toString();
        default:
          return response.body;
      }
    } on Exception catch (e) {
      log(e.toString());
      return "Something went wrong, please check your internet connection.";
    }
  }
}
