import 'package:flutter/material.dart';
import 'package:glass_calculator/core/routes/route_names.dart';
import 'package:glass_calculator/features/calculator/screens/calculator.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.calc,
    routes: [
      GoRoute(
        path: RouteNames.calc,
        name: RouteNames.calc,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const Calculator(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(microseconds: 400),
        ),
      ),
    ],
  );
}
