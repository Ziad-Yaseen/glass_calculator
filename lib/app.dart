import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_calculator/core/routes/app_router.dart';
import 'package:glass_calculator/core/theme/app_theme.dart';

class GlassCalc extends StatelessWidget {
  const GlassCalc({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        title: 'Glass Calculator',
      ),
    );
  }
}
