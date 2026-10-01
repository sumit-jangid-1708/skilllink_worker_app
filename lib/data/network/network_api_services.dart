import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


import '../app_exceptions.dart';
import '../storage/app_storage.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  Future<dynamic> deleteApi(String url) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders();
      final response = await http.delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  Future<dynamic> multipartApi(String method, Map<String, String> data,
      String url, Map<String, String> files) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders();
      headers.remove('Content-Type');
      final request = http.MultipartRequest(method, Uri.parse(url));
      request.headers.addAll(headers);
      request.fields.addAll(data);
      for (final file in files.entries) {
        request.files.add(await http.MultipartFile.fromPath(file.key, file.value));
      }
      final response = await http.Response.fromStream(
          await request.send().timeout(const Duration(seconds: 10)));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  // ✅ Auth header helper
  Future<Map<String, String>> _getHeaders({bool requiresAuth = true}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (requiresAuth) {
      final token = AppStorage.getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  @override
  Future<dynamic> getApi(String url, {bool requiresAuth = true}) async {
    if (kDebugMode) print(url);
    dynamic responseJson;
    try {
      final headers = await _getHeaders(requiresAuth: requiresAuth);
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi(data, String url, {bool requiresAuth = false}) async {
    if (kDebugMode) print(url);
    dynamic responseJson;
    try {
      final headers = await _getHeaders(requiresAuth: requiresAuth);
      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  // ✅ PATCH method — status update ke liye
  @override
  Future<dynamic> patchApi(data, String url) async {
    if (kDebugMode) print(url);
    dynamic responseJson;
    try {
      final headers = await _getHeaders();
      final response = await http
          .patch(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }
}

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:  // ✅ 201 Created bhi add kiya
      return jsonDecode(response.body);
    case 400:
      return jsonDecode(response.body);
    case 401:
      throw UnauthorizedException('Please login again');
    case 403:
      throw FetchDataException('Permission denied');
    case 404:
      throw FetchDataException('Not found');
    default:
      throw FetchDataException(
          'Error occurred while communication with server: ${response.statusCode}');
  }
}
