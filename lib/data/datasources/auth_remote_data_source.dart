import 'package:dio/dio.dart';
import 'package:perfect_wedding_planner/core/constants/api_constants.dart';
import 'package:perfect_wedding_planner/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
  
  Future<void> forgotPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  
  AuthRemoteDataSourceImpl(this.dio);
  
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      
      // In a real implementation, this would parse the API response
      // For mock purposes, we'll return a fake user
      return UserModel(
        id: 'user-123',
        name: 'John Doe',
        email: email,
        isEmailVerified: true,
      );
    } catch (e) {
      throw Exception('Failed to login: ${e.toString()}');
    }
  }
  
  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      
      // In a real implementation, this would parse the API response
      // For mock purposes, we'll return a fake user
      return UserModel(
        id: 'user-${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        isEmailVerified: false,
      );
    } catch (e) {
      throw Exception('Failed to register: ${e.toString()}');
    }
  }
  
  @override
  Future<void> forgotPassword(String email) async {
    try {
      await dio.post(
        ApiConstants.forgotPassword,
        data: {
          'email': email,
        },
      );
    } catch (e) {
      throw Exception('Failed to send password reset email: ${e.toString()}');
    }
  }
}