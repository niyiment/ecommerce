import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Route names for navigation
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String settings = '/settings';
}

@riverpod
GoRouter goRouter(GoRouterProvider ref) => GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      // Splash Route
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        pageBuilder: (BuildContext context, GoRouterState state) =>
          _buildPageWithTransition(context, state, const Placeholder(),),
      ),
      // Onboarding Route
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageWithTransition(context, state, const Placeholder(),),
      ),
      // Home Route
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageWithTransition(context, state, const Placeholder(),),
      ),
      // P Route
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageWithTransition(context, state, const Placeholder(),),
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red,),
              const SizedBox(height: 16,),
              Text('Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8,),
              Text(state.error?.toString() ?? 'Unknown error',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.home),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      )
  );



// Helper function to build page with fade transition
CustomTransitionPage<void> _buildPageWithTransition (
    BuildContext context,
    GoRouterState state,
    Widget child,
    ) => CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
    ) => FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCubic)
        .animate(animation),
        child: child,
      )
  );



/// Navigation extension for easy navigation
extension NavigationExtension on BuildContext {
  void navigateTo(String route) => go(route);
  void replaceTo(String route) => pushReplacement(route);
  void goBack() => pop();
  void goToHome() => go(AppRoutes.home);
  void goToSettings() => go(AppRoutes.settings);
  void goToOnboarding() => go(AppRoutes.onboarding);
}

