import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/vendor.dart';
import '../../domain/repositories/vendor_repository.dart';

class VendorRepositoryImpl implements VendorRepository {


  @override
  Future<Either<Failure, void>> delete(String id) {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, List<Vendor>>> getWeddingVendors(String weddingId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<VendorCategory>>> getVendorCategories() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Vendor>>> getVendorsByCategory(String weddingId, String categoryId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateVendorStatus(String vendorId, VendorStatus status) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> addVendorReview(String vendorId, VendorReview review) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Vendor>> create(Vendor entity) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Vendor>> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Vendor>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Vendor>> update(Vendor entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
