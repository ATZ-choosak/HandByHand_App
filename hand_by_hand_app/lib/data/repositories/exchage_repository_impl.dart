import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hand_by_hand_app/data/models/exchange/exchange_model.dart';
import 'package:hand_by_hand_app/data/source/api_endpoints.dart';
import 'package:hand_by_hand_app/data/source/dio_client.dart';
import 'package:hand_by_hand_app/domain/repositories/exchange_repository.dart';
import 'package:hand_by_hand_app/presentation/bloc/exchange_bloc/bloc/exchange_bloc.dart';

class ExchageRepositoryImpl extends ExchangeRepository {
  final DioClient dioClient;

  ExchageRepositoryImpl({required this.dioClient});

  @override
  Future<Either> checkRequest(CheckRequestExchangeEvent checkRequestReq) async {
    try {
      final response = await dioClient.dio
          .post(ApiEndpoints.checkExchange, data: checkRequestReq.toMap());

      if (response.statusCode == 200) {
        final dynamic data = response.data;
        final checkData = ExchangeCheck.fromJson(data);

        return Right(checkData);
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
  Future<Either> exchangeRequest(ExchageRequestEvent exchangeRequestReq) async {
    try {
      final response = await dioClient.dio
          .post(ApiEndpoints.exchangeRequest, data: exchangeRequestReq.toMap());

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
  Future<Either> exchageInComing() async {
    try {
      final response = await dioClient.dio.get(ApiEndpoints.incoming);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<ExchangeInComing> inComing = data
            .map(
              (e) => ExchangeInComing.fromJson(e),
            )
            .toList();

        return Right(inComing);
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
  Future<Either> exchageOutGoing() async {
    try {
      final response = await dioClient.dio.get(ApiEndpoints.outGoing);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<ExchangeOutGoing> outGoing = data
            .map(
              (e) => ExchangeOutGoing.fromJson(e),
            )
            .toList();

        return Right(outGoing);
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
  Future<Either> accept(ExchangeAcceptEvent exchangeAcceptReq) async {
    try {
      final response = await dioClient.dio
          .post(ApiEndpoints.exchangeAccept, data: exchangeAcceptReq.toMap());

      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "ยอมรับสำเร็จ";

        return Right(message);
      } else {
        final message = response.data["message"] ?? "ยอมรับไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "ยอมรับไม่สำเร็จ";

      return Left(message);
    }
  }

  @override
  Future<Either> reject(ExchangeRejectEvent exchangeRejectReq) async {
    try {
      final response = await dioClient.dio
          .post(ApiEndpoints.exchangeReject, data: exchangeRejectReq.toMap());

      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "ปฎิเสธสำเร็จ";

        return Right(message);
      } else {
        final message = response.data["message"] ?? "ปฎิเสธไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "ปฎิเสธไม่สำเร็จ";

      return Left(message);
    }
  }
  
  @override
  Future<Either> checkUuid(CheckUuidEvent checkUuidReq) async {
    try {
      final response = await dioClient.dio
          .post(ApiEndpoints.checkUuid, data: checkUuidReq.toMap());

      print(response.data);

      if (response.statusCode == 200) {
        final message = response.data["message"] ?? "แลกเปลี่ยนสำเร็จ";

        return Right(message);
      } else {
        final message = response.data["message"] ?? "แลกเปลี่ยนไม่สำเร็จ";
        return Left(message);
      }
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "แลกเปลี่ยนไม่สำเร็จ";

       print(e.response?.data);

      return Left(message);
    }
  }
}
