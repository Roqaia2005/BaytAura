import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';
import 'package:bayt_aura/features/auth/presentation/views/auth_view.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';
import 'package:bayt_aura/features/customer/presentation/views/customer_view.dart';
import 'package:bayt_aura/features/property/presentation/views/favorites_view.dart';
import 'package:bayt_aura/features/property/presentation/views/property_details.dart';
import 'package:bayt_aura/features/admin/presentation/views/admin_dashboard_view.dart';
import 'package:bayt_aura/features/provider/presentation/views/provider_dashboard.dart';
import 'package:bayt_aura/features/property/presentation/views/all_properties_view.dart';
import 'package:bayt_aura/features/provider/presentation/views/provider_properties_view.dart';




class AppRouter {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.customerScreen:
        return MaterialPageRoute(builder: (_) => CustomerView());

      case Routes.providerScreen:
        return MaterialPageRoute(builder: (_) => ProviderDashboard());
      case Routes.adminScreen:
        return MaterialPageRoute(builder: (_) => AdminDashboard());

      case Routes.allProperties:
        return MaterialPageRoute(builder: (_) => AllPropertiesView());

      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case Routes.favoritesScreen:
        return MaterialPageRoute(builder: (_) => FavoritesView());
      case Routes.messagesScreen:
        return MaterialPageRoute(builder: (_) => PostsView());
      // case Routes.categoriesScreen:
      //   return MaterialPageRoute(builder: (_) => AllCategoriesView());
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
