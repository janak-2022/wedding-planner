import '../../domain/entities/timeline_event.dart';

class TimelineEventModel extends TimelineEvent {
  TimelineEventModel({
    required String id,
    required String weddingId,
    required String title,
    required DateTime date,
    required EventStatus status,
    required int order,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    String? description,
    List<String>? assignedUserIds,
  }) : super(
          id: id,
          weddingId: weddingId,
          title: title,
          date: date,
          status: status,
          order: order,
          startTime: startTime,
          endTime: endTime,
          location: location,
          description: description,
          assignedUserIds: assignedUserIds,
        );

  factory TimelineEventModel.fromJson(Map<String, dynamic> json) {
    return TimelineEventModel(
      id: json['id'],
      weddingId: json['weddingId'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      status: EventStatus.values.byName(json['status']),
      order: json['order'],
      startTime: json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      location: json['location'],
      description: json['description'],
      assignedUserIds: List<String>.from(json['assignedUserIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weddingId': weddingId,
      'title': title,
      'date': date.toIso8601String(),
      'status': status.name,
      'order': order,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'location': location,
      'description': description,
      'assignedUserIds': assignedUserIds,
    };
  }
}
