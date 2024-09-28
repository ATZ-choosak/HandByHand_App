import 'package:dartz/dartz.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';

abstract class CategoryRepository {
  Future<Either<String, List<CategorySelectedModel>>> getCategories();
}
