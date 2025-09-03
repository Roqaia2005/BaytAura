import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/features/auth/data/repos/login_repo.dart';
import 'package:bayt_aura/features/auth/data/repos/signup_repo.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';


final getIt = GetIt.instance;
Future<void> setUpGetIt() async {
  Dio dio = Dio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));
}
