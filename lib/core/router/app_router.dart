import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perfect_wedding_planner/presentation/screens/auth/forgot_password_screen.dart';
import 'package:perfect_wedding_planner/presentation/screens/auth/login_screen.dart';
import 'package:perfect_wedding_planner/presentation/screens/auth/register_screen.dart';
import 'package:perfect_wedding_planner/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:perfect_wedding_planner/presentation/screens/onboarding/splash_screen.dart';
import 'package:perfect_wedding_planner/presentation/screens/tabs/budget/budget_screen.dart';
import 'package:perfect_wedding_planner/presentation/screens/tabs/checklist/checklist_screen.dart';
import 'package:perfect_wedding_planner/presentation/screens/tabs/guests/guest_screen.dart';
import 'package:perfect_wedding_planner/presentation/screens/tabs/home/home_screen.dart';
import 'package:perfect_wedding_planner/presentation/screens/tabs/vendors/vendor_screen.dart';
import 'package:perfect_wedding_planner/presentation/widgets/main_tab_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_wedding_planner/core/constants/storage_constants.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/',
      routes: [
        // Splash and onboarding
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        
        // Auth routes
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        
        // Main tab scaffold that contains all the main app tabs
        ShellRoute(
          builder: (context, state, child) {
            return MainTabScaffold(child: child);
          },
          routes: [
            // Home tab
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
              routes: [
                // Add nested routes for home screens here
              ],
            ),
            
            // Checklist tab
            GoRoute(
              path: '/checklist',
              builder: (context, state) => const ChecklistScreen(),
              routes: [
                // Add nested routes for checklist screens here
              ],
            ),
            
            // Guests tab
            GoRoute(
              path: '/guests',
              builder: (context, state) => const GuestScreen(),
              routes: [
                // Add nested routes for guest screens here
              ],
            ),
            
            // Budget tab
            GoRoute(
              path: '/budget',
              builder: (context, state) => const BudgetScreen(),
              routes: [
                // Add nested routes for budget screens here
              ],
            ),
            
            // Vendors tab
            GoRoute(
              path: '/vendors',
              builder: (context, state) => const VendorScreen(),
              routes: [
                // Add nested routes for vendor screens here
              ],
            ),
          ],
        ),
      ],
      
      // Redirect based on authentication state
      redirect: (context, state) {
        final sharedPreferences = GetIt.instance<SharedPreferences>();
        final isOnboardingComplete = sharedPreferences.getBool(StorageConstants.isOnboardingComplete) ?? false;
        final authToken = sharedPreferences.getString(StorageConstants.authToken);
        final isLoggedIn = authToken != null && authToken.isNotEmpty;
        
        // Check if the user is on the splash screen
        final isSplash = state.matchedLocation == '/';
        if (isSplash) {
          return null; // Don't redirect from splash
        }
        
        // Check if the user has completed onboarding
        if (!isOnboardingComplete) {
          return '/onboarding';
        }
        
        // Check if the user is logged in
        final isAuthRoute = 
            state.matchedLocation == '/login' ||
            state.matchedLocation == '/register' ||
            state.matchedLocation == '/forgot-password';
            
        if (!isLoggedIn) {
          return isAuthRoute ? null : '/login';
        }
        
        // If the user is logged in and tries to access auth routes
        if (isLoggedIn && isAuthRoute) {
          return '/home';
        }
        
        return null;
      },
      
      // Handle 404 errors
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Not Found'),
        ),
        body: Center(
          child: Text('No route found for ${state.matchedLocation}'),
        ),
      ),
    );
  }
}