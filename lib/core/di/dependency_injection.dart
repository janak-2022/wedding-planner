import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_wedding_planner/core/network/dio_client.dart';
import 'package:perfect_wedding_planner/core/router/app_router.dart';
import 'package:perfect_wedding_planner/data/datasources/auth_remote_data_source.dart';
import 'package:perfect_wedding_planner/data/repositories/auth_repository_impl.dart';
import 'package:perfect_wedding_planner/data/repositories/budget_repository_impl.dart';
import 'package:perfect_wedding_planner/data/repositories/checklist_repository_impl.dart';
import 'package:perfect_wedding_planner/data/repositories/guest_repository_impl.dart';
import 'package:perfect_wedding_planner/data/repositories/vendor_repository_impl.dart';
import 'package:perfect_wedding_planner/domain/repositories/auth_repository.dart';
import 'package:perfect_wedding_planner/domain/repositories/budget_repository.dart';
import 'package:perfect_wedding_planner/domain/repositories/checklist_repository.dart';
import 'package:perfect_wedding_planner/domain/repositories/guest_repository.dart';
import 'package:perfect_wedding_planner/domain/repositories/vendor_repository.dart';
import 'package:perfect_wedding_planner/domain/usecases/auth/login_usecase.dart';
import 'package:perfect_wedding_planner/domain/usecases/auth/register_usecase.dart';
import 'package:perfect_wedding_planner/presentation/blocs/auth/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  
  // Router
  getIt.registerSingleton<AppRouter>(AppRouter());

  // Network
  getIt.registerSingleton<Dio>(DioClient.createDio());
  
  // Data sources
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(getIt<Dio>()),
  );
  
  // Repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );
  
  getIt.registerSingleton<GuestRepository>(GuestRepositoryImpl());
  getIt.registerSingleton<BudgetRepository>(BudgetRepositoryImpl());
  getIt.registerSingleton<ChecklistRepository>(ChecklistRepositoryImpl());
  getIt.registerSingleton<VendorRepository>(VendorRepositoryImpl());
  
  // Use cases
  getIt.registerFactory<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  
  getIt.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );
  
  // Cubits
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
    ),
  );
}