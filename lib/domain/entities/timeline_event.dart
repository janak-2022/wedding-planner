enum EventStatus { pending, inProgress, completed, cancelled }

class TimelineEvent {
  final String id;
  final String weddingId;
  final String title;
  final DateTime date;
  final EventStatus status;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? location;
  final String? description;
  final List<String>? assignedUserIds;
  final int order;

  TimelineEvent({
    required this.id,
    required this.weddingId,
    required this.title,
    required this.date,
    required this.status,
    required this.order,
    this.startTime,
    this.endTime,
    this.location,
    this.description,
    this.assignedUserIds,
  });
}
