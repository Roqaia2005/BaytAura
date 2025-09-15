import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:bayt_aura/core/networking/dio_factory.dart';
import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/features/home/logic/property_cubit.dart';
import 'package:bayt_aura/features/auth/data/repos/login_repo.dart';
import 'package:bayt_aura/features/auth/data/repos/signup_repo.dart';
import 'package:bayt_aura/features/home/data/property_repository.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';

final getIt = GetIt.instance;
Future<void> setUpGetIt() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  //property repo and cubit

  getIt.registerLazySingleton<PropertyRepository>(
    () => PropertyRepository(apiService: getIt()),
  );
  getIt.registerFactory<PropertyCubit>(() => PropertyCubit(getIt()));
}
