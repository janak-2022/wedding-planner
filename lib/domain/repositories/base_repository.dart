import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';

abstract class BaseRepository<T> {
  Future<Either<Failure, T>> create(T entity);

  Future<Either<Failure, T>> get(String id);

  Future<Either<Failure, List<T>>> getAll();

  Future<Either<Failure, T>> update(T entity);

  Future<Either<Failure, void>> delete(String id);
}
