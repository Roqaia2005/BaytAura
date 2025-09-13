import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/features/home/data/models/property.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';
import 'package:bayt_aura/features/home/presentation/views/home_view.dart';
import 'package:bayt_aura/features/auth/presentation/views/auth_view.dart';
import 'package:bayt_aura/features/home/presentation/views/posts_view.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';
import 'package:bayt_aura/features/favorites/presentation/views/favorites_view.dart';
import 'package:bayt_aura/features/home/presentation/views/alll_categories_view.dart';
import 'package:bayt_aura/features/favorites/presentation/views/property_details.dart';

class AppRouter {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case Routes.favoritesScreen:
        return MaterialPageRoute(builder: (_) => FavoritesView());
      case Routes.messagesScreen:
        return MaterialPageRoute(builder: (_) => PostsView());
      case Routes.categoriesScreen:
        return MaterialPageRoute(builder: (_) =>AllCategoriesView());
      case Routes.detailsScreen:
        final property = arguments as Property;

        return MaterialPageRoute(
          builder: (_) => PropertyDetailsView(property: property),
        );
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
