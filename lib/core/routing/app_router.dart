import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/features/home/home_view.dart';
import 'package:bayt_aura/features/chat/ui/chat_screen.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/features/chat/logic/chat_cubit.dart';
import 'package:bayt_aura/features/admin/logic/admin_cubit.dart';
import 'package:bayt_aura/features/property/logic/media_cubit.dart';
import 'package:bayt_aura/features/profile/logic/profile_cubit.dart';
import 'package:bayt_aura/features/auth/logic/cubits/login_cubit.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/property/data/models/property.dart';
import 'package:bayt_aura/features/auth/logic/cubits/sign_up_cubit.dart';
import 'package:bayt_aura/features/auth/presentation/views/auth_view.dart';
import 'package:bayt_aura/features/customer/logic/customer_request_cubit.dart';
import 'package:bayt_aura/features/customer/data/models/customer_request.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';
import 'package:bayt_aura/features/customer/presentation/views/customer_view.dart';
import 'package:bayt_aura/features/property/presentation/views/favorites_view.dart';
import 'package:bayt_aura/features/property/presentation/views/property_details.dart';
import 'package:bayt_aura/features/admin/presentation/views/admin_dashboard_view.dart';
import 'package:bayt_aura/features/property/presentation/views/edit_property_view.dart';
import 'package:bayt_aura/features/profile/presentation/views/edit_profile_screen.dart';
import 'package:bayt_aura/features/provider/presentation/views/provider_dashboard.dart';
import 'package:bayt_aura/features/customer/presentation/views/all_properties_view.dart';
import 'package:bayt_aura/features/admin/presentation/views/customer_request_details.dart';
import 'package:bayt_aura/features/provider/presentation/views/provider_request_submitted_view.dart';



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
          builder: (_) => BlocProvider(
            create: (_) => getIt<PropertyCubit>(),

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
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<PropertyCubit>()),
              BlocProvider(create: (context) => getIt<MediaCubit>()),
            ],
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
      case Routes.providerRequestSubmittedView:
        return MaterialPageRoute(
          builder: (_) => ProviderRequestSubmittedView(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.chatScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ChatCubit>(),
            child: ChatScreen(),
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
