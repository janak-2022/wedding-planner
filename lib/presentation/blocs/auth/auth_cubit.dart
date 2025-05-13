import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perfect_wedding_planner/domain/usecases/auth/login_usecase.dart';
import 'package:perfect_wedding_planner/domain/usecases/auth/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  
  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
  }) : super(const AuthInitial());
  
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    
    try {
      final result = await loginUseCase.execute(
        email: email,
        password: password,
      );
      
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(const AuthSuccess()),
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
  
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    
    try {
      final result = await registerUseCase.execute(
        name: name,
        email: email,
        password: password,
      );
      
      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(const AuthSuccess()),
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
  
  void reset() {
    emit(const AuthInitial());
  }
}