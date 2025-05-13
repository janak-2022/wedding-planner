import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perfect_wedding_planner/core/constants/storage_constants.dart';
import 'package:perfect_wedding_planner/core/theme/app_colors.dart';
import 'package:perfect_wedding_planner/core/theme/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to Your Wedding Journey',
      description: 'Plan your dream wedding with our comprehensive tools and stay organized every step of the way.',
      image: 'https://images.pexels.com/photos/1128782/pexels-photo-1128782.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      color: AppColors.primary,
    ),
    OnboardingPage(
      title: 'Stay on Budget',
      description: 'Track all your expenses, set budget limits, and receive notifications when you\'re approaching your limits.',
      image: 'https://images.pexels.com/photos/7166798/pexels-photo-7166798.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      color: AppColors.secondary,
    ),
    OnboardingPage(
      title: 'Manage Your Guest List',
      description: 'Keep track of RSVPs, meal preferences, and special accommodations for your guests in one place.',
      image: 'https://images.pexels.com/photos/2291462/pexels-photo-2291462.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      color: Color(0xFF6C63FF),
    ),
    OnboardingPage(
      title: 'Find Perfect Vendors',
      description: 'Discover and connect with top-rated vendors in your area, read reviews, and request quotes.',
      image: 'https://images.pexels.com/photos/1793037/pexels-photo-1793037.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      color: Color(0xFF4CAF50),
    ),
  ];
  
  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }
  
  void _completeOnboarding() async {
    final prefs = GetIt.instance<SharedPreferences>();
    await prefs.setBool(StorageConstants.isOnboardingComplete, true);
    
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _buildPage(_pages[index]);
            },
          ),
          
          // Bottom navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip button (only show if not on last page)
                  _currentPage < _pages.length - 1
                      ? TextButton(
                          onPressed: _completeOnboarding,
                          child: const Text('Skip'),
                        )
                      : const SizedBox(width: 64),
                  
                  // Page indicators
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 8,
                        width: index == _currentPage ? 24 : 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: index == _currentPage
                              ? _pages[_currentPage].color
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  
                  // Next/Done button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _pages.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _completeOnboarding();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _pages[_currentPage].color,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                      elevation: 0,
                    ),
                    child: Icon(
                      _currentPage < _pages.length - 1
                          ? Icons.arrow_forward
                          : Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPage(OnboardingPage page) {
    return Container(
      padding: const EdgeInsets.only(
        top: 100,
        left: 24,
        right: 24,
        bottom: 100,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                page.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: page.color,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: page.color.withOpacity(0.1),
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: page.color,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 48),
          
          // Title
          Text(
            page.title,
            style: TextStyles.headline3.copyWith(
              color: page.color,
              fontFamily: 'Playfair',
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            page.description,
            style: TextStyles.body1.copyWith(
              color: AppColors.textMedium,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;
  final Color color;
  
  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.color,
  });
}