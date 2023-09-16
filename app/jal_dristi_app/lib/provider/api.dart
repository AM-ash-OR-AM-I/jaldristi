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

  // Just for demo purpose [will be replaced]
  static Future<String> demo({
    required String text,
    required String from,
    required String to,
  }) async {
    final authToken = await getAuthToken();
    Map<String, String> params = {
      "text": text,
      "source_language": from,
      "target_language": to,
    };
    log("Translate params = $params");
    final response = await post(
      Uri.https(authority, "api/translate", params),
      headers: {
        HttpHeaders.authorizationHeader: authToken!,
      },
    );
    String translatedText = utf8.decode(
      (jsonDecode(response.body)["translated"] as String).runes.toList(),
    );
    log("Translate status = ${response.body}, responseCode = ${response.statusCode}");
    return translatedText;
  }
}
