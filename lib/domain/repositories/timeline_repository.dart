import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/timeline_event.dart';
import 'base_repository.dart';

abstract class TimelineRepository extends BaseRepository<TimelineEvent> {
  Future<Either<Failure, List<TimelineEvent>>> getWeddingEvents(String weddingId);
  Future<Either<Failure, List<TimelineEvent>>> getEventsByDate(String weddingId, DateTime date);
  Future<Either<Failure, void>> reorderEvents(String weddingId, List<String> eventIds);
  Future<Either<Failure, void>> updateEventStatus(String eventId, EventStatus status);
} 