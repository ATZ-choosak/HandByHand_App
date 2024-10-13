import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/data/source/api_endpoints.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/domain/repositories/my_item_repository.dart';
import 'package:hand_by_hand_app/presentation/bloc/my_item_bloc/bloc/my_item_bloc.dart';

class MyItemRepositoryImpl extends MyItemRepository {
  final DioClient dioClient;

  MyItemRepositoryImpl({required this.dioClient});

  @override
  Future<Either<String, GetAllMyItemModel>> getMyItem() async {
    try {
      final response = await dioClient.dio.get(ApiEndpoints.myItem);

      if (response.statusCode == 200) {
        final dynamic data = response.data;
        final allItems = GetAllMyItemModel.fromJson(data);

        return Right(allItems);
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
  Future<Either> deleteItem(DeleteMyItemEvent deleteItemReq) async {
    try {
      final response =
          await dioClient.dio.delete(ApiEndpoints.deleteItem(deleteItemReq.id));

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
