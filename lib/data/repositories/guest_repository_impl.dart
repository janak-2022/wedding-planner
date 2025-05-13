import 'package:dartz/dartz.dart';
import 'package:perfect_wedding_planner/core/error/failures.dart';
import 'package:perfect_wedding_planner/domain/entities/guest.dart';
import 'package:perfect_wedding_planner/domain/repositories/guest_repository.dart';

class GuestRepositoryImpl implements GuestRepository {
  @override
  Future<List<Guest>> getGuests() async {
    // TODO: Implement API call to fetch guests
    throw UnimplementedError();
  }

  @override
  Future<Guest> addGuest(Guest guest) async {
    // TODO: Implement API call to add guest
    throw UnimplementedError();
  }

  @override
  Future<void> updateGuest(Guest guest) async {
    // TODO: Implement API call to update guest
    throw UnimplementedError();
  }

  @override
  Future<void> deleteGuest(String guestId) async {
    // TODO: Implement API call to delete guest
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }


  @override
  Future<Either<Failure, void>> importGuests(String weddingId, List<dynamic> guests) {
    // TODO: implement importGuests
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateGuestStatus(String guestId, status) {
    // TODO: implement updateGuestStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Guest>> create(Guest entity) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Guest>> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Guest>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Guest>>> getWeddingGuests(String weddingId) {
    // TODO: implement getWeddingGuests
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Guest>> update(Guest entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
} 