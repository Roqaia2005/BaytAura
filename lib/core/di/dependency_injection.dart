import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:bayt_aura/core/networking/dio_factory.dart';
import 'package:bayt_aura/core/networking/api_service.dart';
import 'package:bayt_aura/core/networking/chat_service.dart';
import 'package:bayt_aura/features/chat/logic/chat_cubit.dart';
import 'package:bayt_aura/features/admin/data/admin_repo.dart';
import 'package:bayt_aura/features/admin/logic/admin_cubit.dart';
import 'package:bayt_aura/features/property/logic/media_cubit.dart';
import 'package:bayt_aura/features/auth/data/repos/login_repo.dart';
import 'package:bayt_aura/features/profile/logic/profile_cubit.dart';
import 'package:bayt_aura/features/auth/data/repos/signup_repo.dart';
import 'package:bayt_aura/features/customer/logic/customer_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';
import 'package:bayt_aura/features/profile/data/repo/profile_repo.dart';
import 'package:bayt_aura/features/property/data/repos/media_repo.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';
import 'package:bayt_aura/features/customer/data/repo/customer_repo.dart';
import 'package:bayt_aura/features/property/data/repos/property_repository.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  getIt.registerLazySingleton<ChatService>(() => ChatService(dio));

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // property
  getIt.registerLazySingleton<PropertyRepository>(
    () => PropertyRepository(apiService: getIt<ApiService>()),
  );
  getIt.registerFactory<PropertyCubit>(
    () => PropertyCubit(getIt<PropertyRepository>(), getIt<MediaRepository>()),
  );

  // admin
  getIt.registerLazySingleton<AdminRepository>(() => AdminRepository(getIt()));
  getIt.registerFactory<AdminCubit>(() => AdminCubit(getIt()));

  getIt.registerLazySingleton<MediaRepository>(
    () => MediaRepository(getIt<ApiService>()),
  );

  // customer
  getIt.registerLazySingleton<CustomerRepo>(
    () => CustomerRepo(apiService: getIt<ApiService>()),
  );

  getIt.registerFactory<CustomerRequestCubit>(
    () => CustomerRequestCubit(getIt<CustomerRepo>()),
  );

  // profile
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(getIt<ApiService>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt<ProfileRepository>()),
  );

  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt<ChatService>()));

  getIt.registerFactory<MediaCubit>(() => MediaCubit(getIt<MediaRepository>()));
}
