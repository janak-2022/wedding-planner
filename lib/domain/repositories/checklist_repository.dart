import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/checklist_item.dart';
import 'base_repository.dart';

abstract class ChecklistRepository extends BaseRepository<ChecklistItem> {
  Future<Either<Failure, List<ChecklistItem>>> getWeddingChecklist(String weddingId);
  Future<Either<Failure, List<ChecklistItem>>> getChecklistByCategory(String weddingId, String categoryId);
  Future<Either<Failure, void>> updateItemStatus(String itemId, ChecklistItemStatus status);
  Future<Either<Failure, void>> reorderItems(String weddingId, List<String> itemIds);
  Future<Either<Failure, void>> assignItem(String itemId, String assigneeId);
} 