import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';
import 'package:bayt_aura/features/home/presentation/views/home_view.dart';
import 'package:bayt_aura/features/auth/presentation/views/auth_view.dart';
import 'package:bayt_aura/features/home/presentation/views/messages_view.dart';
import 'package:bayt_aura/features/home/presentation/views/favorites_view.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';

class AppRouter {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this(argument as className)
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case Routes.favoritesScreen:
        return MaterialPageRoute(builder: (_) => FavoritesView());
      case Routes.messagesScreen:
        return MaterialPageRoute(builder: (_) => MessagesView());
      case Routes.authScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<SignupCubit>()),
              BlocProvider(create: (context) => getIt<LoginCubit>()),
            ],
            child: const AuthView(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text('Unknown Route')),
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
