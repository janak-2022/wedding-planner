import 'package:dio/dio.dart';
import 'package:perfect_wedding_planner/core/constants/storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final sharedPreferences = GetIt.instance<SharedPreferences>();
    final token = sharedPreferences.getString(StorageConstants.authToken);
    
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 errors (unauthorized)
    if (err.response?.statusCode == 401) {
      // TODO: Implement token refresh or logout logic
    }
    
    handler.next(err);
  }
}