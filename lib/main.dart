import 'package:flutter/material.dart';
import 'package:bayt_aura/bayt_aura_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/features/admin/logic/admin_cubit.dart';
import 'package:bayt_aura/features/search/logic/search_cubit.dart';
import 'package:bayt_aura/features/customer/logic/customer_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';

void main() {
  setUpGetIt();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PropertyCubit>(create: (_) => getIt<PropertyCubit>()),
        BlocProvider<SearchCubit>(create: (_) => getIt<SearchCubit>()),
        BlocProvider<LoginCubit>(create: (_) => getIt<LoginCubit>()),
        BlocProvider<SignupCubit>(create: (_) => getIt<SignupCubit>()),
        BlocProvider<CustomerRequestCubit>(
          create: (_) => getIt<CustomerRequestCubit>(),
        ),
        BlocProvider<AdminCubit>(create: (_) => getIt<AdminCubit>()),
      ],
      child: const BaytAura(),
    ),
  );
}
