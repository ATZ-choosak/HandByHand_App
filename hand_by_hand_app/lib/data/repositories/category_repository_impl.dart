import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';
import 'package:hand_by_hand_app/data/source/api_endpoints.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final DioClient dioClient;

  CategoryRepositoryImpl({required this.dioClient});

  @override
  Future<Either<String, List<CategorySelectedModel>>> getCategories() async {
    try {
      final response = await dioClient.dio.get(ApiEndpoints.getCategories);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final categories =
            data.map((json) => CategorySelectedModel.fromJson(json)).toList();

        return Right(categories);
      } else {
        final message = response.data["message"] ?? "ไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "ไม่สำเร็จ";
      return Left(message);
    }
  }

  @override
  Future<Either> categoryInteresting(CategoryInterestingInput categorys) async {
    try {
      final response = await dioClient.dio
          .post(ApiEndpoints.categoryInteresting, data: categorys.toJson());

      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "สำเร็จ";
        return Right(message);
      } else {
        final message = response.data["message"] ?? "ไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "ไม่สำเร็จ";
      return Left(message);
    }
  }
}
