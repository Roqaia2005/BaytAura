import 'package:flutter/material.dart';
import 'package:bayt_aura/core/routing/routes.dart';
import 'package:bayt_aura/core/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaytAura extends StatelessWidget {
  const BaytAura({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.authScreen,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
