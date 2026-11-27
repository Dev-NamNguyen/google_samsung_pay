import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:google_samsung_pay/core/data/app_exceptions.dart';
import 'package:google_samsung_pay/core/data/network/app_error.dart';
import 'package:google_samsung_pay/core/data/network/base_api_services.dart';
import 'package:google_samsung_pay/core/services/session_manager.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  final SessionManager _sessionManager = SessionManager.instance;

  @override
  Future getApiResponse(String url, {Map<String, String>? queries}) async {
    print("🚀 ~ NetworkApiServices ~ FuturegetApiResponse ~ url: $url");
    dynamic responseJS;
    try {
      if (queries != null && queries.isNotEmpty) {
        url += convertQueryParams(queries);
      }
      print("📤 ~ NetworkApiServices ~ GET Request ~ final url: $url");
      final headers = await _getHeaders();
      final response = await http
          .get(Uri.parse(url.trim()), headers: headers)
          .timeout(const Duration(minutes: 2));

      responseJS = responseJson(response);
    } on SocketException {
      throw InternetException('No Internet connection');
    }

    return responseJS;
  }

  @override
  Future<dynamic> postApiResponse(
    String url,
    data, {
    Map<String, String>? queries,
  }) async {
    print("🚀 ~ NetworkApiServices ~ POST Request ~ url: $url");
    print("📤 ~ NetworkApiServices ~ POST Request ~ data: $data");

    try {
      if (queries != null && queries.isNotEmpty) {
        url += convertQueryParams(queries);
      }
      print("📤 ~ NetworkApiServices ~ POST Request ~ final url: $url");
      final headers = await _getHeaders();
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: headers)
          .timeout(const Duration(seconds: 10));

      print(
        "📥 ~ NetworkApiServices ~ POST Response ~ statusCode: ${response.statusCode}",
      );
      print("📥 ~ NetworkApiServices ~ POST Response ~ body: ${response.body}");

      return responseJson(response);
    } on SocketException {
      print("❌ ~ NetworkApiServices ~ POST Error ~ No Internet");
      throw InternetException("NO Internet is available right now");
    } catch (e) {
      print("❌ ~ NetworkApiServices ~ POST Error ~ $e");
      rethrow;
    }
  }

  // Get headers with authentication token
  Future<Map<String, String>> _getHeaders() async {
    final headers = <String, String>{'Content-Type': 'application/json'};

    // Add authorization header if token exists
    final token = _sessionManager.token;
    if (token != null && !_sessionManager.isTokenExpired) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  dynamic responseJson(http.Response response) {
    print(
      "🔍 ~ NetworkApiServices ~ responseJson ~ statusCode: ${response.statusCode}",
    );

    switch (response.statusCode) {
      case 200:
      case 201:
        print("✅ ~ NetworkApiServices ~ Success Response");
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        print("❌ ~ NetworkApiServices ~ Bad Request (400)");
        throw AppError(
          json.decode(response.body)['message'] ?? 'Bad Request',
          status: response.statusCode,
        );
      case 401:
        print("❌ ~ NetworkApiServices ~ Unauthorized (401)");
        // Token might be expired, try to refresh
        _handleTokenExpired();
        throw AppError(
          json.decode(response.body)['message'] ?? 'Unauthorized',
          status: response.statusCode,
        );
      case 500:
        print("❌ ~ NetworkApiServices ~ Server Error (500)");
        throw AppError(
          json.decode(response.body)['message'] ?? 'Server Error',
          status: response.statusCode,
        );
      case > 400:
        print("❌ ~ NetworkApiServices ~ Error ${response.statusCode}");
        throw AppError(
          json.decode(response.body)['message'] ?? 'Unknown error',
          status: response.statusCode,
        );
      default:
        print(
          "❌ ~ NetworkApiServices ~ Unexpected Error ${response.statusCode}",
        );
        throw InternetException(
          "${response.statusCode} : ${response.reasonPhrase}",
        );
    }
  }

  // Handle token expired
  void _handleTokenExpired() {
    _sessionManager.clearSession();
  }

  @override
  Future deleteApiResponse(String url) {
    throw UnimplementedError();
  }

  // ...existing code...

  @override
  Future<dynamic> putApiResponse(
    String url, {
    dynamic data,
    Map<String, String>? queries,
  }) async {
    final uri = Uri.parse(url).replace(
      queryParameters: {
        if (Uri.parse(url).queryParameters.isNotEmpty)
          ...Uri.parse(url).queryParameters,
        if (queries != null) ...queries,
      },
    );

    print("🚀 PUT Request -> $uri");
    if (data != null) print("📤 PUT Payload: $data");

    try {
      final headers = await _getHeaders();

      Object? body;
      if (data != null) {
        if (data is String) {
          // Giả sử đã là JSON string
          body = data;
        } else {
          body = jsonEncode(data);
        }
      }

      final response = await http
          .put(uri, headers: headers, body: body)
          .timeout(const Duration(seconds: 10));

      print("📥 PUT Response status: ${response.statusCode}");
      print("📥 PUT Response body: ${response.body}");

      if (response.statusCode >= 400) {
        // Tùy chỉnh ngoại lệ rõ ràng hơn
        throw HttpException(
          'PUT ${uri.path} failed (${response.statusCode})',
          uri: uri,
        );
      }

      return responseJson(response);
    } on SocketException {
      print("❌ PUT Error: No Internet");
      throw InternetException("NO Internet is available right now");
    } on TimeoutException {
      print("⏰ PUT Timeout");
      throw TimeoutException("PUT request timeout");
    } catch (e) {
      print("❌ PUT Unexpected Error: $e");
      rethrow;
    }
  }

  // ...existing code...

  String convertQueryParams(Map<String, String> queries) {
    if (queries.isEmpty) return '';
    return '?' + queries.entries.map((e) => '${e.key}=${e.value}').join('&');
  }
}
