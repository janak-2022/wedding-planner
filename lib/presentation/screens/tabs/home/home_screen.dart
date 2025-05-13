import 'package:flutter/material.dart';
import 'package:perfect_wedding_planner/core/theme/app_colors.dart';
import 'package:perfect_wedding_planner/core/theme/text_styles.dart';
import 'package:perfect_wedding_planner/presentation/widgets/countdown_timer.dart';
import 'package:perfect_wedding_planner/presentation/widgets/progress_tracker.dart';
import 'package:perfect_wedding_planner/presentation/widgets/task_card.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - would come from a repository in real app
    final weddingDate = DateTime(2024, 10, 15);
    final formattedDate = DateFormat('MMMM d, y').format(weddingDate);
    final upcomingTasks = [
      {
        'title': 'Book Photographer',
        'dueDate': DateTime(2024, 6, 10),
        'priority': 'High',
        'isCompleted': false,
      },
      {
        'title': 'Send Save the Dates',
        'dueDate': DateTime(2024, 6, 15),
        'priority': 'Medium',
        'isCompleted': false,
      },
      {
        'title': 'Schedule Cake Tasting',
        'dueDate': DateTime(2024, 6, 18),
        'priority': 'Medium',
        'isCompleted': false,
      },
    ];

    final completedTasks = 12;
    final totalTasks = 50;
    final percentComplete = (completedTasks / totalTasks * 100).toInt();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.gradientStart,
                      AppColors.gradientEnd,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        const Text(
                          'Jessica & Michael',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Playfair',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: const SafeArea(
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              centerTitle: true,
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white),
                onPressed: () {
                  // Navigate to notifications
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
                onPressed: () {
                  // Navigate to settings
                },
              ),
            ],
          ),

          // Main content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Countdown timer
                  CountdownTimer(weddingDate: weddingDate),
                  const SizedBox(height: 24),

                  // Progress tracker
                  ProgressTracker(
                    title: 'Wedding Planning Progress',
                    subtitle: '$completedTasks of $totalTasks tasks completed',
                    progress: percentComplete / 100,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 24),

                  // Quick actions
                  Text(
                    'Quick Actions',
                    style: TextStyles.headline5,
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildQuickAction(
                          context: context,
                          icon: Icons.person_add_outlined,
                          label: 'Add Guest',
                          onTap: () {
                            // Navigate to add guest
                          },
                        ),
                        _buildQuickAction(
                          context: context,
                          icon: Icons.add_task,
                          label: 'Add Task',
                          onTap: () {
                            // Navigate to add task
                          },
                        ),
                        _buildQuickAction(
                          context: context,
                          icon: Icons.attach_money,
                          label: 'Log Expense',
                          onTap: () {
                            // Navigate to log expense
                          },
                        ),
                        _buildQuickAction(
                          context: context,
                          icon: Icons.storefront_outlined,
                          label: 'Find Vendor',
                          onTap: () {
                            // Navigate to find vendor
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Upcoming tasks
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Tasks',
                        style: TextStyles.headline5,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to all tasks
                        },
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Task list
                  ...upcomingTasks
                      .map((task) => TaskCard(
                            title: task['title'] as String,
                            dueDate: task['dueDate'] as DateTime,
                            priority: task['priority'] as String,
                            isCompleted: task['isCompleted'] as bool,
                            onCompleted: (value) {
                              // Update task completion status
                            },
                          ))
                      .toList(),

                  const SizedBox(height: 24),

                  // Reminders section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.campaign_outlined,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Reminders',
                              style: TextStyles.headline6.copyWith(
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '• Consider sending save-the-dates 6-8 months before your wedding',
                          style: TextStyles.body2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '• Book your photographer at least 8-10 months in advance',
                          style: TextStyles.body2,
                        ),
                      ],
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

  Widget _buildQuickAction({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyles.body2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
