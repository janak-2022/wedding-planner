import 'package:flutter/material.dart';
import 'package:perfect_wedding_planner/core/theme/app_colors.dart';
import 'package:perfect_wedding_planner/core/theme/text_styles.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            onPressed: () {
              // Navigate to add guest screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: const _GuestListContent(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigate to add guest screen
        },
      ),
    );
  }
}

class _GuestListContent extends StatelessWidget {
  const _GuestListContent();

  @override
  Widget build(BuildContext context) {
    // Mock data for guest list
    final guestGroups = {
      'Family': [
        _GuestModel(
          name: 'John Smith',
          email: 'john.smith@example.com',
          phone: '+1 (555) 123-4567',
          rsvpStatus: RSVPStatus.confirmed,
          group: 'Family',
        ),
        _GuestModel(
          name: 'Mary Smith',
          email: 'mary.smith@example.com',
          phone: '+1 (555) 123-4568',
          rsvpStatus: RSVPStatus.confirmed,
          group: 'Family',
        ),
      ],
      'Friends': [
        _GuestModel(
          name: 'David Johnson',
          email: 'david.johnson@example.com',
          phone: '+1 (555) 234-5678',
          rsvpStatus: RSVPStatus.pending,
          group: 'Friends',
        ),
        _GuestModel(
          name: 'Sarah Williams',
          email: 'sarah.williams@example.com',
          phone: '+1 (555) 345-6789',
          rsvpStatus: RSVPStatus.declined,
          group: 'Friends',
        ),
      ],
      'Colleagues': [
        _GuestModel(
          name: 'Michael Brown',
          email: 'michael.brown@example.com',
          phone: '+1 (555) 456-7890',
          rsvpStatus: RSVPStatus.pending,
          group: 'Colleagues',
        ),
      ],
    };
    
    // Summary stats
    final totalInvited = guestGroups.values.fold(
      0,
      (sum, guests) => sum + guests.length,
    );
    
    final confirmedGuests = guestGroups.values.fold(
      0,
      (sum, guests) => sum + guests.where((g) => g.rsvpStatus == RSVPStatus.confirmed).length,
    );
    
    final pendingGuests = guestGroups.values.fold(
      0,
      (sum, guests) => sum + guests.where((g) => g.rsvpStatus == RSVPStatus.pending).length,
    );
    
    final declinedGuests = guestGroups.values.fold(
      0,
      (sum, guests) => sum + guests.where((g) => g.rsvpStatus == RSVPStatus.declined).length,
    );
    
    return Column(
      children: [
        // Summary card
        Container(
          margin: const EdgeInsets.all(16),
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
            children: [
              const Text(
                'Guest Summary',
                style: TextStyles.headline6,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('Total', totalInvited, Colors.grey.shade700),
                  _buildStat('Confirmed', confirmedGuests, AppColors.success),
                  _buildStat('Pending', pendingGuests, AppColors.warning),
                  _buildStat('Declined', declinedGuests, AppColors.error),
                ],
              ),
            ],
          ),
        ),
        
        // Guest list
        Expanded(
          child: ListView.builder(
            itemCount: guestGroups.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final groupName = guestGroups.keys.elementAt(index);
              final guests = guestGroups[groupName]!;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      groupName,
                      style: TextStyles.headline6,
                    ),
                  ),
                  ...guests.map((guest) => _GuestCard(guest: guest)),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildStat(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyles.headline5.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyles.caption.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _GuestCard extends StatelessWidget {
  final _GuestModel guest;
  
  const _GuestCard({required this.guest});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;
    
    switch (guest.rsvpStatus) {
      case RSVPStatus.confirmed:
        statusColor = AppColors.success;
        statusText = 'Confirmed';
        break;
      case RSVPStatus.declined:
        statusColor = AppColors.error;
        statusText = 'Declined';
        break;
      case RSVPStatus.pending:
        statusColor = AppColors.warning;
        statusText = 'Pending';
        break;
    }
    
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
          backgroundColor: AppColors.primary.withOpacity(0.1),
          foregroundColor: AppColors.primary,
          child: Text(
            guest.name.substring(0, 1),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          guest.name,
          style: TextStyles.body1.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              guest.email,
              style: TextStyles.caption,
            ),
            const SizedBox(height: 2),
            Text(
              guest.phone,
              style: TextStyles.caption,
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            statusText,
            style: TextStyles.caption.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          // Navigate to guest details
        },
      ),
    );
  }
}

enum RSVPStatus {
  confirmed,
  declined,
  pending,
}

class _GuestModel {
  final String name;
  final String email;
  final String phone;
  final RSVPStatus rsvpStatus;
  final String group;
  
  const _GuestModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.rsvpStatus,
    required this.group,
  });
}