import 'package:dartz/dartz.dart';
import 'package:hand_by_hand_app/presentation/bloc/exchange_bloc/bloc/exchange_bloc.dart';

abstract class ExchangeRepository {
  Future<Either> checkRequest(CheckRequestExchangeEvent checkRequestReq);
  Future<Either> exchangeRequest(ExchageRequestEvent exchangeRequestReq);
  Future<Either> exchageInComing();
  Future<Either> exchageOutGoing();
  Future<Either> accept(ExchangeAcceptEvent exchangeAcceptReq);
  Future<Either> reject(ExchangeRejectEvent exchangeRejectReq);
  Future<Either> checkUuid(CheckUuidEvent checkUuidReq);
}
