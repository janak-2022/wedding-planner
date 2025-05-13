import 'package:dartz/dartz.dart';
import 'package:perfect_wedding_planner/core/error/failures.dart';
import 'package:perfect_wedding_planner/core/constants/storage_constants.dart';
import 'package:perfect_wedding_planner/data/datasources/auth_remote_data_source.dart';
import 'package:perfect_wedding_planner/data/models/user_model.dart';
import 'package:perfect_wedding_planner/domain/entities/user.dart';
import 'package:perfect_wedding_planner/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;
  
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });
  
  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      // This would normally call the API
      // For mock purposes, we'll create a fake user
      await Future.delayed(const Duration(seconds: 2));
      
      final user = UserModel(
        id: 'user-123',
        name: 'John Doe',
        email: email,
        profileImage: null,
        phone: null,
        isEmailVerified: true,
      );
      
      // Store auth token in SharedPreferences
      await sharedPreferences.setString(StorageConstants.authToken, 'fake-token-${DateTime.now().millisecondsSinceEpoch}');
      await sharedPreferences.setString(StorageConstants.userId, user.id);
      await sharedPreferences.setString(StorageConstants.userProfile, json.encode(user.toJson()));
      
      return Right(user.user);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to login: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // This would normally call the API
      // For mock purposes, we'll create a fake user
      await Future.delayed(const Duration(seconds: 2));
      
      final user = UserModel(
        id: 'user-${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        profileImage: null,
        phone: null,
        isEmailVerified: false,
      );
      
      // Store auth token in SharedPreferences
      await sharedPreferences.setString(StorageConstants.authToken, 'fake-token-${DateTime.now().millisecondsSinceEpoch}');
      await sharedPreferences.setString(StorageConstants.userId, user.id);
      await sharedPreferences.setString(StorageConstants.userProfile, json.encode(user.toJson()));
      
      return Right(user.user);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to register: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Clear auth data from SharedPreferences
      await sharedPreferences.remove(StorageConstants.authToken);
      await sharedPreferences.remove(StorageConstants.userId);
      await sharedPreferences.remove(StorageConstants.userProfile);
      
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to logout: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userJson = sharedPreferences.getString(StorageConstants.userProfile);
      if (userJson == null) {
        return const Right(null);
      }
      
      final user = UserModel.fromJson(json.decode(userJson) as Map<String, dynamic>);
      return Right(user.user);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get current user: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      // This would normally call the API
      await Future.delayed(const Duration(seconds: 2));
      
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to send password reset email: ${e.toString()}'));
    }
  }
}