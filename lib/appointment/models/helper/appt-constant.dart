import 'dart:io';

class ApptConstants {
  static const String messageKey = 'message';
  static const String responseCodeKey = 'responseCode';
  static const String responseKey = 'response';

  static Map<String, String> createHeader(
      [String token = " ", List<Map<String, dynamic>> analytic]) {
    return {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'analytic': analytic.toString()
    };
  }
}
