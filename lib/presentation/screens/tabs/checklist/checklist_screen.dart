import 'package:flutter/material.dart';
import 'package:perfect_wedding_planner/core/theme/app_colors.dart';
import 'package:perfect_wedding_planner/core/theme/text_styles.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Checklist'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Complete'),
            Tab(text: 'All'),
          ],
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primary,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add task action
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Filter tasks
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _TaskListTab(showCompleted: false),
          _TaskListTab(showCompleted: true),
          _TaskListTab(showAll: true),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          // Add task action
        },
      ),
    );
  }
}

class _TaskListTab extends StatelessWidget {
  final bool showCompleted;
  final bool showAll;
  
  const _TaskListTab({
    this.showCompleted = false,
    this.showAll = false,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data for tasks
    final allTasks = [
      _TaskModel(
        id: '1',
        title: 'Book venue',
        dueDate: DateTime(2024, 6, 15),
        category: 'Venue',
        priority: TaskPriority.high,
        isCompleted: true,
        notes: 'Need to book at least 10-12 months in advance',
      ),
      _TaskModel(
        id: '2',
        title: 'Hire photographer',
        dueDate: DateTime(2024, 7, 1),
        category: 'Vendors',
        priority: TaskPriority.high,
        isCompleted: false,
        notes: 'Check portfolio and references',
      ),
      _TaskModel(
        id: '3',
        title: 'Book caterer',
        dueDate: DateTime(2024, 7, 15),
        category: 'Food & Drinks',
        priority: TaskPriority.high,
        isCompleted: false,
        notes: 'Arrange for tasting session',
      ),
      _TaskModel(
        id: '4',
        title: 'Send save-the-dates',
        dueDate: DateTime(2024, 8, 1),
        category: 'Invitations',
        priority: TaskPriority.medium,
        isCompleted: false,
      ),
      _TaskModel(
        id: '5',
        title: 'Book DJ/Band',
        dueDate: DateTime(2024, 8, 15),
        category: 'Entertainment',
        priority: TaskPriority.medium,
        isCompleted: false,
      ),
      _TaskModel(
        id: '6',
        title: 'Order wedding cake',
        dueDate: DateTime(2024, 9, 1),
        category: 'Food & Drinks',
        priority: TaskPriority.medium,
        isCompleted: false,
        notes: 'Schedule cake tasting',
      ),
    ];
    
    // Filter tasks based on completion status
    final filteredTasks = showAll
        ? allTasks
        : allTasks.where((task) => task.isCompleted == showCompleted).toList();
    
    // Group tasks by month
    final groupedTasks = <String, List<_TaskModel>>{};
    for (final task in filteredTasks) {
      final monthYear = '${_getMonthName(task.dueDate.month)} ${task.dueDate.year}';
      if (groupedTasks.containsKey(monthYear)) {
        groupedTasks[monthYear]!.add(task);
      } else {
        groupedTasks[monthYear] = [task];
      }
    }
    
    // Sort months
    final sortedMonths = groupedTasks.keys.toList()
      ..sort((a, b) {
        final aDate = _parseMonthYear(a);
        final bDate = _parseMonthYear(b);
        return aDate.compareTo(bDate);
      });
    
    return filteredTasks.isEmpty
        ? _buildEmptyState(showCompleted)
        : ListView.builder(
            itemCount: sortedMonths.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final monthYear = sortedMonths[index];
              final tasksForMonth = groupedTasks[monthYear]!;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Text(
                      monthYear,
                      style: TextStyles.headline5,
                    ),
                  ),
                  ...tasksForMonth.map((task) => _TaskCard(
                    task: task,
                    onCompletedChanged: (isCompleted) {
                      // Update task completion status
                    },
                  )),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
  }
  
  Widget _buildEmptyState(bool showCompleted) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            showCompleted ? Icons.check_circle : Icons.assignment,
            size: 72,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            showCompleted
                ? 'No completed tasks yet'
                : 'No upcoming tasks',
            style: TextStyles.headline5.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            showCompleted
                ? 'Complete some tasks to see them here'
                : 'Add tasks to start planning your wedding',
            style: TextStyles.body2.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }
  
  DateTime _parseMonthYear(String monthYear) {
    final parts = monthYear.split(' ');
    final month = _getMonthIndex(parts[0]);
    final year = int.parse(parts[1]);
    return DateTime(year, month);
  }
  
  int _getMonthIndex(String monthName) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames.indexOf(monthName) + 1;
  }
}

class _TaskCard extends StatelessWidget {
  final _TaskModel task;
  final Function(bool) onCompletedChanged;
  
  const _TaskCard({
    required this.task,
    required this.onCompletedChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Format date
    final day = task.dueDate.day.toString().padLeft(2, '0');
    final month = task.dueDate.month.toString().padLeft(2, '0');
    final formattedDate = '$month/$day';
    
    // Determine priority color
    Color priorityColor;
    switch (task.priority) {
      case TaskPriority.high:
        priorityColor = AppColors.error;
        break;
      case TaskPriority.medium:
        priorityColor = AppColors.warning;
        break;
      case TaskPriority.low:
        priorityColor = AppColors.info;
        break;
    }
    
    // Calculate days remaining
    final now = DateTime.now();
    final difference = task.dueDate.difference(now).inDays;
    final daysText = difference == 0
        ? 'Today'
        : difference == 1
            ? 'Tomorrow'
            : difference > 0
                ? '$difference days'
                : 'Overdue';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Transform.scale(
          scale: 1.2,
          child: Checkbox(
            value: task.isCompleted,
            onChanged: (value) => onCompletedChanged(value ?? false),
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        title: Text(
          task.title,
          style: TextStyles.body1.copyWith(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? Colors.grey : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task.priority.name.toUpperCase(),
                    style: TextStyles.caption.copyWith(
                      color: priorityColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task.category,
                    style: TextStyles.caption.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (task.notes != null && task.notes!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                task.notes!,
                style: TextStyles.caption.copyWith(
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formattedDate,
              style: TextStyles.caption.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              daysText,
              style: TextStyles.caption.copyWith(
                color: difference < 0
                    ? AppColors.error
                    : difference <= 7
                        ? AppColors.warning
                        : Colors.grey[600],
              ),
            ),
          ],
        ),
        onTap: () {
          // Navigate to task details
        },
      ),
    );
  }
}

enum TaskPriority {
  high,
  medium,
  low,
}

class _TaskModel {
  final String id;
  final String title;
  final DateTime dueDate;
  final String category;
  final TaskPriority priority;
  final bool isCompleted;
  final String? notes;
  
  const _TaskModel({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.category,
    required this.priority,
    required this.isCompleted,
    this.notes,
  });
}