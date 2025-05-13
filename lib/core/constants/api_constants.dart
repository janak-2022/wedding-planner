import 'package:perfect_wedding_planner/core/config/env_config.dart';

class ApiConstants {
  static String get baseUrl => EnvConfig.baseUrl;
  
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  
  // Wedding endpoints
  static const String wedding = '/wedding';
  
  // Guest endpoints
  static const String guests = '/guests';
  
  // Budget endpoints
  static const String budget = '/budget';
  static const String expenses = '/expenses';
  
  // Checklist endpoints
  static const String checklist = '/checklist';
  
  // Vendor endpoints
  static const String vendors = '/vendors';
}