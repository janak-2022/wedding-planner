import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/budget.dart';
import 'base_repository.dart';

abstract class BudgetRepository extends BaseRepository<BudgetItem> {
  Future<Either<Failure, BudgetCategory>> createCategory(BudgetCategory category);
  Future<Either<Failure, List<BudgetCategory>>> getCategories(String weddingId);
  Future<Either<Failure, List<BudgetItem>>> getBudgetItems(String categoryId);
  Future<Either<Failure, double>> getTotalBudget(String weddingId);
  Future<Either<Failure, Map<String, double>>> getCategoryTotals(String weddingId);
  Future<Either<Failure, void>> updateBudgetLimit(String categoryId, double limit);
  Future<Either<Failure, void>> transferBudget(String fromCategoryId, String toCategoryId, double amount);
  Future<Either<Failure, List<BudgetItem>>> getOverBudgetItems(String weddingId);
} 