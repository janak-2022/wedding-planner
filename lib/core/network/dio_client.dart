import 'package:dio/dio.dart';
import 'package:perfect_wedding_planner/core/config/env_config.dart';
import 'package:perfect_wedding_planner/core/constants/api_constants.dart';
import 'package:perfect_wedding_planner/core/network/interceptors/auth_interceptor.dart';
import 'package:perfect_wedding_planner/core/network/interceptors/logging_interceptor.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) {
          return status != null && status >= 200 && status < 300;
        },
      ),
    );

    // Add interceptors
    dio.interceptors.add(AuthInterceptor());
    if (EnvConfig.isDevelopment) {
      dio.interceptors.add(LoggingInterceptor());
    }

    // Add error handling
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            error = DioException(
              requestOptions: error.requestOptions,
              error: 'Connection timeout. Please check your internet connection.',
              type: error.type,
            );
            break;
          case DioExceptionType.badResponse:
            switch (error.response?.statusCode) {
              case 400:
                error = DioException(
                  requestOptions: error.requestOptions,
                  error: 'Bad request. Please check your input.',
                  type: error.type,
                  response: error.response,
                );
                break;
              case 401:
                error = DioException(
                  requestOptions: error.requestOptions,
                  error: 'Unauthorized. Please login again.',
                  type: error.type,
                  response: error.response,
                );
                break;
              case 403:
                error = DioException(
                  requestOptions: error.requestOptions,
                  error: 'Forbidden. You don\'t have permission to access this resource.',
                  type: error.type,
                  response: error.response,
                );
                break;
              case 404:
                error = DioException(
                  requestOptions: error.requestOptions,
                  error: 'Resource not found.',
                  type: error.type,
                  response: error.response,
                );
                break;
              case 500:
                error = DioException(
                  requestOptions: error.requestOptions,
                  error: 'Internal server error. Please try again later.',
                  type: error.type,
                  response: error.response,
                );
                break;
            }
            break;
          case DioExceptionType.cancel:
            error = DioException(
              requestOptions: error.requestOptions,
              error: 'Request cancelled.',
              type: error.type,
            );
            break;
          default:
            error = DioException(
              requestOptions: error.requestOptions,
              error: 'Something went wrong. Please try again later.',
              type: error.type,
            );
        }
        return handler.next(error);
      },
    ));

    return dio;
  }
}