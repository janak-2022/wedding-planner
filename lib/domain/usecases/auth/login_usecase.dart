import 'package:dartz/dartz.dart';
import 'package:perfect_wedding_planner/domain/entities/user.dart';
import 'package:perfect_wedding_planner/domain/repositories/auth_repository.dart';
import 'package:perfect_wedding_planner/core/error/failures.dart';

class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  Future<Either<Failure, User>> execute({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}