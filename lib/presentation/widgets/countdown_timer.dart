import 'package:flutter/material.dart';
import 'package:perfect_wedding_planner/core/theme/app_colors.dart';
import 'package:perfect_wedding_planner/core/theme/text_styles.dart';

class CountdownTimer extends StatelessWidget {
  final DateTime weddingDate;
  
  const CountdownTimer({
    Key? key,
    required this.weddingDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = weddingDate.difference(now);
    
    // Calculate days, hours, minutes remaining
    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);
    
    return Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            'Your Big Day',
            style: TextStyles.headline6.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeUnit(days.toString(), 'Days'),
              const _TimeSeparator(),
              _buildTimeUnit(hours.toString().padLeft(2, '0'), 'Hours'),
              const _TimeSeparator(),
              _buildTimeUnit(minutes.toString().padLeft(2, '0'), 'Minutes'),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTimeUnit(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyles.headline4.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyles.body2.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _TimeSeparator extends StatelessWidget {
  const _TimeSeparator();

  @override
  Widget build(BuildContext context) {
    return Text(
      ':',
      style: TextStyles.headline3.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}