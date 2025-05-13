import 'package:flutter/material.dart';
import 'package:perfect_wedding_planner/core/di/dependency_injection.dart';
import 'package:perfect_wedding_planner/core/router/app_router.dart';
import 'package:perfect_wedding_planner/core/theme/app_theme.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize dependencies
  await initDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    
    return MaterialApp.router(
      title: 'Perfect Wedding Planner',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Default to light theme
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.router,
    );
  }
}