import 'package:dartz/dartz.dart';
import 'package:perfect_wedding_planner/core/error/failures.dart';
import 'package:perfect_wedding_planner/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  });
  
  Future<Either<Failure, void>> logout();
  
  Future<Either<Failure, User?>> getCurrentUser();
  
  Future<Either<Failure, void>> forgotPassword(String email);
}