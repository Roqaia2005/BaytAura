import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/features/admin/logic/admin_cubit.dart';
import 'package:bayt_aura/features/search/logic/search_cubit.dart';
import 'package:bayt_aura/features/profile/logic/profile_cubit.dart';
import 'package:bayt_aura/features/customer/logic/customer_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';
import 'package:bayt_aura/features/auth/presentation/views/auth_view.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';
import 'package:bayt_aura/features/customer/presentation/views/customer_view.dart';
import 'package:bayt_aura/features/property/presentation/views/favorites_view.dart';
import 'package:bayt_aura/features/property/presentation/views/property_details.dart';
import 'package:bayt_aura/features/admin/presentation/views/admin_dashboard_view.dart';
import 'package:bayt_aura/features/property/presentation/views/edit_property_view.dart';
import 'package:bayt_aura/features/profile/presentation/views/edit_profile_screen.dart';
import 'package:bayt_aura/features/provider/presentation/views/provider_dashboard.dart';
import 'package:bayt_aura/features/property/presentation/views/all_properties_view.dart';
import 'package:bayt_aura/features/admin/presentation/views/customer_request_details.dart';

class AppRouter {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.customerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<CustomerRequestCubit>(),
            child: CustomerView(),
          ),
        );

      case Routes.providerScreen:
        return MaterialPageRoute(builder: (_) => ProviderDashboard());

      case Routes.adminScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AdminCubit>(),
            child: AdminDashboard(),
          ),
        );

      case Routes.allProperties:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<PropertyCubit>()..fetchProperties(),
              ),
              BlocProvider(create: (_) => getIt<SearchCubit>()),
            ],
            child: AllPropertiesView(),
          ),
        );

      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ProfileCubit>(),
            child: ProfileView(),
          ),
        );

      case Routes.favoritesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<PropertyCubit>()..fetchFavorites(),
            child: FavoritesView(),
          ),
        );

      case Routes.detailsScreen:
        final property = arguments as Property;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<PropertyCubit>(),
            child: PropertyDetailsView(property: property),
          ),
        );

      case Routes.customerRequestDetails:
        final customerRequest = arguments as CustomerRequest;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<PropertyCubit>(),
            child: CustomerRequestDetailsView(customerRequest: customerRequest),
          ),
        );

      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ProfileCubit>(),
            child: EditProfileView(),
          ),
        );

      case Routes.editProperty:
        final property = arguments as Property;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<PropertyCubit>(),
            child: EditPropertyView(property: property),
          ),
        );

      case Routes.authScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<SignupCubit>()),
              BlocProvider(create: (_) => getIt<LoginCubit>()),
            ],
            child: const AuthView(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Unknown Route')),
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
