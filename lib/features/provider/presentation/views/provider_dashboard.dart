import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/core/di/dependency_injection.dart';
import 'package:bayt_aura/features/property/logic/property_cubit.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';
import 'package:bayt_aura/features/property/presentation/views/my_properties.dart';
import 'package:bayt_aura/features/provider/presentation/views/add_post_view.dart';
import 'package:bayt_aura/features/provider/presentation/widgets/provider_navbar.dart';

class ProviderDashboard extends StatefulWidget {
  const ProviderDashboard({super.key});

  @override
  State<ProviderDashboard> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  final List<Widget> screens = [
    MyPropertiesView(),
    AddPostView(),

    ProfileView(),
  ];
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<PropertyCubit>()..fetchMyProperties(),
        ),
      ],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: AppColors.blue,
          onPressed: () {},
          child: SvgPicture.asset("assets/svgs/ai.svg"),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: ProviderNavBar(
          currentPageIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            currentPageIndex = index;
            setState(() {});
          },
        ),
        body: screens[currentPageIndex],
      ),
    );
  }
}
