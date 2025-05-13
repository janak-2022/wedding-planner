import 'package:flutter/material.dart';
import 'package:perfect_wedding_planner/core/theme/app_colors.dart';
import 'package:perfect_wedding_planner/core/theme/text_styles.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add expense action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: const _BudgetContent(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          // Add expense action
        },
      ),
    );
  }
}

class _BudgetContent extends StatelessWidget {
  const _BudgetContent();

  @override
  Widget build(BuildContext context) {
    // Mock data for budget
    const totalBudget = 25000.0;
    const spentAmount = 12750.0;
    const remainingAmount = totalBudget - spentAmount;
    const progress = spentAmount / totalBudget;
    
    // Mock data for expense categories
    final expenseCategories = [
      _ExpenseCategoryModel(
        name: 'Venue',
        budget: 10000.0,
        spent: 8500.0,
        color: Colors.blue,
      ),
      _ExpenseCategoryModel(
        name: 'Catering',
        budget: 5000.0,
        spent: 2500.0,
        color: Colors.green,
      ),
      _ExpenseCategoryModel(
        name: 'Photography',
        budget: 3000.0,
        spent: 1000.0,
        color: Colors.purple,
      ),
      _ExpenseCategoryModel(
        name: 'Attire',
        budget: 2000.0,
        spent: 750.0,
        color: Colors.orange,
      ),
      _ExpenseCategoryModel(
        name: 'Decor',
        budget: 1500.0,
        spent: 0.0,
        color: Colors.teal,
      ),
    ];
    
    // Mock data for recent expenses
    final recentExpenses = [
      _ExpenseModel(
        title: 'Venue Deposit',
        amount: 5000.0,
        date: DateTime(2024, 5, 15),
        category: 'Venue',
        vendor: 'Grand Plaza Hotel',
      ),
      _ExpenseModel(
        title: 'Catering Deposit',
        amount: 1000.0,
        date: DateTime(2024, 5, 10),
        category: 'Catering',
        vendor: 'Gourmet Catering Co.',
      ),
      _ExpenseModel(
        title: 'Wedding Dress',
        amount: 750.0,
        date: DateTime(2024, 5, 5),
        category: 'Attire',
        vendor: 'Elegant Bridal',
      ),
      _ExpenseModel(
        title: 'Photography Package',
        amount: 1000.0,
        date: DateTime(2024, 5, 2),
        category: 'Photography',
        vendor: 'Memories Photography',
      ),
    ];
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Budget overview card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primaryDark,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Total Budget',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '\$25,000',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  color: Colors.white,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBudgetStat(
                      label: 'Spent',
                      amount: spentAmount,
                      textColor: Colors.white,
                    ),
                    _buildBudgetStat(
                      label: 'Remaining',
                      amount: remainingAmount,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Expense categories
          Text(
            'Expense Categories',
            style: TextStyles.headline5,
          ),
          const SizedBox(height: 16),
          ...expenseCategories.map((category) => _CategoryProgressCard(
            category: category,
          )),
          
          const SizedBox(height: 24),
          
          // Recent expenses
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Expenses',
                style: TextStyles.headline5,
              ),
              TextButton(
                onPressed: () {
                  // View all expenses
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...recentExpenses.map((expense) => _ExpenseCard(
            expense: expense,
          )),
          
          const SizedBox(height: 80), // Extra space for FAB
        ],
      ),
    );
  }
  
  Widget _buildBudgetStat({
    required String label,
    required double amount,
    required Color textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '\$${amount.toStringAsFixed(0)}',
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _CategoryProgressCard extends StatelessWidget {
  final _ExpenseCategoryModel category;
  
  const _CategoryProgressCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final progress = category.spent / category.budget;
    final remainingAmount = category.budget - category.spent;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name,
                style: TextStyles.headline6.copyWith(
                  color: category.color,
                ),
              ),
              Text(
                '\$${category.spent.toInt()} / \$${category.budget.toInt()}',
                style: TextStyles.body2.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade200,
            color: category.color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Text(
            'Remaining: \$${remainingAmount.toInt()}',
            style: TextStyles.caption.copyWith(
              color: remainingAmount < 0 ? AppColors.error : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpenseCard extends StatelessWidget {
  final _ExpenseModel expense;
  
  const _ExpenseCard({required this.expense});

  @override
  Widget build(BuildContext context) {
    // Format date
    final day = expense.date.day.toString().padLeft(2, '0');
    final month = expense.date.month.toString().padLeft(2, '0');
    final year = expense.date.year;
    final formattedDate = '$month/$day/$year';
    
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
        leading: CircleAvatar(
          backgroundColor: AppColors.secondary.withOpacity(0.1),
          foregroundColor: AppColors.secondary,
          child: const Icon(Icons.receipt_long),
        ),
        title: Text(
          expense.title,
          style: TextStyles.body1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              expense.vendor,
              style: TextStyles.caption,
            ),
            const SizedBox(height: 2),
            Row(
              children: [
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
                    expense.category,
                    style: TextStyles.caption.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formattedDate,
                  style: TextStyles.caption,
                ),
              ],
            ),
          ],
        ),
        trailing: Text(
          '\$${expense.amount.toInt()}',
          style: TextStyles.body1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          // Navigate to expense details
        },
      ),
    );
  }
}

class _ExpenseCategoryModel {
  final String name;
  final double budget;
  final double spent;
  final Color color;
  
  const _ExpenseCategoryModel({
    required this.name,
    required this.budget,
    required this.spent,
    required this.color,
  });
}

class _ExpenseModel {
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final String vendor;
  
  const _ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.vendor,
  });
}