import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio _api;
  String baseURL = 'http://34.16.137.128/api';
  String accessToken = '';

  DioClient() : _api = Dio() {
    _configureInterceptors();
    _loadToken();
  }

  void _configureInterceptors() {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAsImZ1bGxuYW1lIjoic3RyaW5nIiwiZW1haWwiOiJ0cmFuaHV1Y2hpbmg1MDBAZ21haWwuY29tIiwicm9sZXMiOlswXSwiaWF0IjoxNzEyNTQ5MDQ0LCJleHAiOjE3MTM3NTg2NDR9.a4HXBpcx15Lub3um4RaB2xHZk1shdCDB4OZqtEDDBnU';

    _api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // print(accessToken);
        options.baseUrl = baseURL;
        options.headers = {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        };

        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) async {
        return handler.next(error);
      },
    ));
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken') ?? '';
  }

  Future<Response<T>> request<T>(
    String uri, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _api.request<T>(
        uri,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }
}
