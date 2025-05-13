import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/wedding.dart';
import 'base_repository.dart';

abstract class WeddingRepository extends BaseRepository<Wedding> {
  Future<Either<Failure, Wedding>> createWedding(Wedding wedding);
  Future<Either<Failure, Wedding>> getWedding(String weddingId);
  Future<Either<Failure, List<Wedding>>> getUserWeddings(String userId);
  Future<Either<Failure, Wedding>> updateWedding(Wedding wedding);
  Future<Either<Failure, void>> deleteWedding(String weddingId);
} 