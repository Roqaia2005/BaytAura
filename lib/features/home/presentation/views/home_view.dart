import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:bayt_aura/core/theming/colors.dart';
import 'package:bayt_aura/features/home/presentation/views/posts_view.dart';
import 'package:bayt_aura/features/home/presentation/views/add_post_view.dart';
import 'package:bayt_aura/features/search/presentation/views/search_view.dart';
import 'package:bayt_aura/features/profile/presentation/views/profile_view.dart';
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
    AddPostView(),
    PostsView(),
    ProfileView(),
  ];
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.blue,
        onPressed: () {},
        child: SvgPicture.asset("assets/svgs/ai.svg"),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: AppNavBar(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          currentPageIndex = index;
          setState(() {});
        },
      ),
      body: screens[currentPageIndex],
    );
  }
}
