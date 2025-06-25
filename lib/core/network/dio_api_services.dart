import 'dart:async';

import 'package:dio/dio.dart';
import 'package:store_demo/core/errors/exceptions.dart';
import 'package:store_demo/core/network/base_api_services.dart';
import 'package:store_demo/core/services/local_storage.dart';
import 'package:store_demo/core/services/logger.dart';
import 'package:store_demo/core/utils/constants/key_storage.dart';
import 'package:store_demo/core/utils/constants/router.dart';

class DioApiServices implements BaseApiServices {
  final Dio _dio;
  String? _token;
  TLocalStorage localStorage;

  DioApiServices({required String baseUrl, required this.localStorage})
    : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Content-Type'] = 'application/json';
          if (!options.path.contains('auth/login')) {
            _token = _token ??= await localStorage.readValue(TKeyStorage.token);

            options.headers['Authorization'] = 'Bearer $_token';
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          // if (error.response?.statusCode == 401) {
          //   _token = null;
          //   final newToken = await refreshToken();
          //   if (newToken != null) {
          //     final options = error.requestOptions;
          //     options.headers['Authorization'] = 'Bearer $newToken';
          //     AppLogger.debug(options.headers['Authorization']);
          //
          //     try {
          //       final response = await _dio.request(
          //         options.path,
          //         options: Options(
          //           method: options.method,
          //           headers: options.headers,
          //         ),
          //         data: options.data,
          //         queryParameters: options.queryParameters,
          //       );
          //
          //       return handler.resolve(response);
          //     } on DioException catch (e) {
          //       return handler.reject(e);
          //     }
          //   }
          // }

          return handler.next(error);
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
        responseHeader: true,
      ),
    );
  }

  Future<String?> refreshToken() async {
    try {
      final refreshToken = await localStorage.readValue(
        TKeyStorage.refreshToken,
      );
      final response = await _dio.post(
        "auth/refresh",
        data: {'refreshToken': refreshToken},
      );

      if (response.data != null) {
        AppLogger.warning(response.data["accessToken"]);
        await localStorage.setValue(
          TKeyStorage.refreshToken,
          response.data["refreshToken"] as String,
        );
        await localStorage.setValue(
          TKeyStorage.token,
          response.data["accessToken"] as String,
        );
        return response.data["accessToken"] as String;
      } else {
        return "";
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return returnResponse(e.response!);
      } else {
        _handleDioException(e);
      }
    }
  }

  @override
  Future delete(String url) async {
    dynamic responseJson;
    try {
      responseJson = await _dio.get(url);
      return returnResponse(responseJson);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return returnResponse(responseJson);
      } else {
        _handleDioException(e);
      }
    }
  }

  @override
  Future get(String url, Map<String, dynamic>? query) async {
    dynamic responseJson;
    try {
      responseJson = await _dio.get(url, queryParameters: query);
      AppLogger.info(url);
      return returnResponse(responseJson);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        AppLogger.info(e.message);
        return returnResponse(responseJson);
      } else {
        _handleDioException(e);
      }
    }
  }

  @override
  Future post(String url, data) async {
    dynamic responseJson;
    try {
      responseJson = await _dio.post(url, data: data);
      return returnResponse(responseJson);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return returnResponse(e.response!);
      } else {
        _handleDioException(e);
      }
    }
  }

  @override
  Future put(String url, data) async {
    dynamic responseJson;
    try {
      responseJson = await _dio.put(url, data: data);
      return returnResponse(responseJson);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return returnResponse(e.response!);
      } else {
        _handleDioException(e);
      }
    }
  }

  dynamic returnResponse(Response response) {
    AppLogger.info(response.statusCode);

    switch (response.statusCode) {
      case 200:
      case 201:
      case 400:
        return response.data;
      case 401:
      // throw UnauthorisedException(response.data.toString());
      case 500:
        throw BadRequestException("");
      case 404:
        // throw BadRequestException(response.data['message']);
        return response.data;
      default:
        throw FetchDataException(
          'Error occurred while communicating with server',
        );
    }
  }

  void _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw FetchDataException('Network request timed out');
    } else if (e.type == DioExceptionType.badResponse) {
      if (e.response?.statusCode == 401) {}
      throw FetchDataException('Bad response: ${e.response?.statusMessage}');
    } else if (e.type == DioExceptionType.connectionError) {
      throw NoInternetException('No internet connection');
    }
    throw FetchDataException('Try again later');
  }
}
