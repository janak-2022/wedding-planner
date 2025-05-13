import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/vendor.dart';
import 'base_repository.dart';

abstract class VendorRepository extends BaseRepository<Vendor> {
  Future<Either<Failure, List<Vendor>>> getWeddingVendors(String weddingId);
  Future<Either<Failure, List<VendorCategory>>> getVendorCategories();
  Future<Either<Failure, List<Vendor>>> getVendorsByCategory(String weddingId, String categoryId);
  Future<Either<Failure, void>> updateVendorStatus(String vendorId, VendorStatus status);
  Future<Either<Failure, void>> addVendorReview(String vendorId, VendorReview review);
} 