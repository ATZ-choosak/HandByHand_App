import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/data/source/api_endpoints.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/domain/repositories/item_repository.dart';
import 'package:hand_by_hand_app/module/get_location.dart';
import 'package:hand_by_hand_app/presentation/bloc/item_bloc/bloc/item_bloc.dart';

class ItemRepositoryImpl extends ItemRepository {
  final DioClient dioClient;

  ItemRepositoryImpl({required this.dioClient});

  @override
  Future<Either> addItem(AddItemEvent addItemReq, List<File> images) async {
    try {
      FormData itemData;
      LocationModel location = await getCurrentLocation();

      if (images.isNotEmpty) {
        List<MultipartFile> allImages = [];

        for (File f in images) {
          allImages.add(await MultipartFile.fromFile(f.path));
        }

        itemData = FormData.fromMap({
          ...addItemReq.toMap(),
          "images": allImages,
          "lon": location.lon,
          "lat": location.lat
        });
      } else {
        itemData = FormData.fromMap(
            {...addItemReq.toMap(), "lon": location.lon, "lat": location.lat});
      }

      final response =
          await dioClient.dio.post(ApiEndpoints.item, data: itemData);

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

  @override
  Future<Either<String, GetAllItemModel>> getItem(
      GetItemEvent getItemReq, String? query) async {
    try {
      Map<String, dynamic> data = getItemReq.toMap();

      if (query != null) {
        data = {...getItemReq.toMap(), "query": query};
      }

      final response =
          await dioClient.dio.get(ApiEndpoints.item, queryParameters: data);

      if (response.statusCode == 200) {
        final dynamic data = response.data;
        final allItems = GetAllItemModel.fromJson(data);

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
  Future<Either> updateItem(
      UpdateItemEvent updateItemReq, List<File> images) async {
    try {
      FormData itemData;
      LocationModel location = await getCurrentLocation();

      if (images.isNotEmpty) {
        List<MultipartFile> allImages = [];

        for (File f in images) {
          allImages.add(await MultipartFile.fromFile(f.path));
        }

        itemData = FormData.fromMap({
          ...updateItemReq.toMap(),
          "images": allImages,
          "lon": location.lon,
          "lat": location.lat
        });
      } else {
        itemData = FormData.fromMap({
          ...updateItemReq.toMap(),
          "lon": location.lon,
          "lat": location.lat
        });
      }

      itemData = FormData.fromMap(
          {...updateItemReq.toMap(), "lon": location.lon, "lat": location.lat});

      final response = await dioClient.dio
          .put(ApiEndpoints.updateItem(updateItemReq.id), data: itemData);

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

  @override
  Future<Either> getItemById(GetItemByIdEvent getItemReq) async {
    try {
      final response = await dioClient.dio.get(
        ApiEndpoints.getItemById(getItemReq.id),
      );

      if (response.statusCode == 200) {
        dynamic data = response.data;

        Item item = Item.fromJson(data);

        return Right(item);
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
