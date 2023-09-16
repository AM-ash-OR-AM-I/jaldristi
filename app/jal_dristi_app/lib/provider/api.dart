import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static const authority = "xxx.yyy.zzzz";
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
        Uri.https(authority, "api/login"),
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

  // Translate text
  static Future<String> translate({
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

  // Delete chat session with the server
  static Future<String> deleteSession(String sessionId) async {
    final authToken = await getAuthToken();
    final response = await delete(
      Uri.https(authority, "api/delete-session", {"session_id": sessionId}),
      headers: {
        HttpHeaders.authorizationHeader: authToken!,
      },
    );
    log("Delete session status = ${response.body}, responseCode = ${response.statusCode}");
    return response.body;
  }

  // Get all chat sessions
  static Future<List<String>> getSessions() async {
    final authToken = await getAuthToken();
    final response = await get(
      Uri.https(authority, "api/get-sessions"),
      headers: {
        HttpHeaders.authorizationHeader: authToken!,
      },
    );
    log("Get sessions status = ${response.body}, responseCode = ${response.statusCode}");
    List<String> sessions =
        jsonDecode(response.body)["sessions"].cast<String>();
    return sessions.reversed.toList();
  }

  // Get chatbot response
  static Future<String> chat({
    required String query,
    required String sessionId,
  }) async {
    final authToken = await getAuthToken();
    final params = {
      "session_id": sessionId,
      "user_message": query,
    };
    final response = await get(
      Uri.https(authority, "api/chat", params),
      headers: {
        HttpHeaders.authorizationHeader: authToken!,
      },
    );
    log("Get chat response = ${response.body}, responseCode = ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        String answer = utf8.decode(
          (jsonDecode(response.body)["message"] as String).runes.toList(),
        );
        return answer;
      case 401:
        throw Exception("Unauthorized, invalid session id");
      default:
        throw Exception("Something went wrong");
    }
  }
}
