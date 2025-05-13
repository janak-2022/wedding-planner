import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perfect_wedding_planner/core/theme/app_colors.dart';

class MainTabScaffold extends StatefulWidget {
  final Widget child;
  
  const MainTabScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<MainTabScaffold> createState() => _MainTabScaffoldState();
}

class _MainTabScaffoldState extends State<MainTabScaffold> {
  int _currentIndex = 0;
  
  final List<String> _tabPaths = [
    '/home',
    '/checklist',
    '/guests',
    '/budget',
    '/vendors',
  ];
  
  final List<String> _tabLabels = [
    'Home',
    'Tasks',
    'Guests',
    'Budget',
    'Vendors',
  ];
  
  final List<IconData> _tabIcons = [
    Icons.home_outlined,
    Icons.check_circle_outline,
    Icons.people_outline,
    Icons.account_balance_wallet_outlined,
    Icons.store_outlined,
  ];
  
  @override
  Widget build(BuildContext context) {
    // Update current index based on location
    final location = GoRouterState.of(context).matchedLocation;
    for (int i = 0; i < _tabPaths.length; i++) {
      if (location.startsWith(_tabPaths[i])) {
        _currentIndex = i;
        break;
      }
    }
    
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            context.go(_tabPaths[index]);
          }
        },
        items: List.generate(
          _tabLabels.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(_tabIcons[index]),
            label: _tabLabels[index],
          ),
        ),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMedium,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}