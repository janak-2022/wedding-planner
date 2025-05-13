import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/guest.dart';
import 'base_repository.dart';

abstract class GuestRepository extends BaseRepository<Guest> {
  Future<Either<Failure, List<Guest>>> getWeddingGuests(String weddingId);
  Future<Either<Failure, void>> importGuests(String weddingId, List<Guest> guests);
  Future<Either<Failure, void>> updateGuestStatus(String guestId, GuestStatus status);
} 