import 'package:dartz/dartz.dart';
import 'package:perfect_wedding_planner/domain/entities/user.dart';
import 'package:perfect_wedding_planner/domain/repositories/auth_repository.dart';
import 'package:perfect_wedding_planner/core/error/failures.dart';

class RegisterUseCase {
  final AuthRepository repository;
  
  RegisterUseCase(this.repository);
  
  Future<Either<Failure, User>> execute({
    required String name,
    required String email,
    required String password,
  }) async {
    return await repository.register(
      name: name,
      email: email,
      password: password,
    );
  }
}