import 'package:flutter/material.dart';
import 'package:bayt_aura/features/home/presentation/views/search_view.dart';
import 'package:bayt_aura/features/home/presentation/views/profile_view.dart';
import 'package:bayt_aura/features/home/presentation/views/messages_view.dart';
import 'package:bayt_aura/features/home/presentation/views/favorites_view.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/app_nav_bar.dart';
import 'package:bayt_aura/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> screens = [
    HomeViewBody(),
    SearchView(),
    FavoritesView(),
    MessagesView(),
    ProfileView(),
  ];
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AppNavBar(
        currentPageIndex: 0,
        onDestinationSelected: (int value) {},
      ),
      body: screens[currentPageIndex],
    );
  }
}
