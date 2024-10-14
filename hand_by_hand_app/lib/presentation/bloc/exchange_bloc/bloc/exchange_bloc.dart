import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hand_by_hand_app/data/models/exchange/exchange_model.dart';
import 'package:hand_by_hand_app/domain/repositories/exchange_repository.dart';
import 'package:meta/meta.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  final ExchangeRepository exchageRepository;

  ExchangeBloc({required this.exchageRepository}) : super(ExchangeInitial()) {
    on<ExchangeInitEvent>(_handleExchangeInitEvent);
    on<CheckRequestExchangeEvent>(_handleCheckRequestExchangeEvent);
    on<ExchangeInComingEvent>(_handleExchangeInComingEvent);
    on<ExchangeOutgoingEvent>(_handleExchangeOutgoingEvent);
    on<ExchageRequestEvent>(_handleExchageRequestEvent);
    on<ExchangeAcceptEvent>(_handleExchangeAcceptEvent);
    on<ExchangeRejectEvent>(_handleExchangeRejectEvent);
    on<CheckUuidEvent>(_handleCheckUuidEvent);
  }

  Future<void> _handleExchangeAcceptEvent(
      ExchangeAcceptEvent event, Emitter<ExchangeState> emit) async {
    emit(ExchangeAcceptLoading());
    final result = await exchageRepository.accept(event);

    result.fold((failure) => emit(ExchangeAcceptFailure(failure)), (success) {
      emit(ExchangeAcceptSuccess(success));
    });
  }

  Future<void> _handleExchangeRejectEvent(
      ExchangeRejectEvent event, Emitter<ExchangeState> emit) async {
    emit(ExchangeRejectLoading());
    final result = await exchageRepository.reject(event);

    result.fold((failure) => emit(ExchangeRejectFailure(failure)), (success) {
      emit(ExchangeRejectSuccess(success));
    });
  }

  Future<void> _handleCheckRequestExchangeEvent(
      CheckRequestExchangeEvent event, Emitter<ExchangeState> emit) async {
    emit(CheckExchangeLoading());
    final result = await exchageRepository.checkRequest(event);

    result.fold((failure) => emit(CheckEXchangeFailure(failure)), (success) {
      emit(CheckExchangeSuccess(check: success));
    });
  }

  Future<void> _handleExchageRequestEvent(
      ExchageRequestEvent event, Emitter<ExchangeState> emit) async {
    emit(ExchangeRequestLoading());
    final result = await exchageRepository.exchangeRequest(event);

    result.fold((failure) => emit(ExchangeRequestFailure(failure)), (success) {
      emit(ExchangeRequestSuccess(success));
    });
  }

  Future<void> _handleExchangeInComingEvent(
      ExchangeInComingEvent event, Emitter<ExchangeState> emit) async {
    emit(ExchangeInComingLoading());
    final result = await exchageRepository.exchageInComing();

    result.fold((failure) => emit(ExchangeInComingFailure(failure)), (success) {
      emit(ExchangeInComingSuccess(incoming: success));
    });
  }

  Future<void> _handleExchangeOutgoingEvent(
      ExchangeOutgoingEvent event, Emitter<ExchangeState> emit) async {
    emit(ExchangeOutGoingLoading());
    final result = await exchageRepository.exchageOutGoing();

    result.fold((failure) => emit(ExchangeOutGoingFailure(failure)), (success) {
      emit(ExchangeOutGoingSuccess(outGoing: success));
    });
  }

  Future<void> _handleCheckUuidEvent(
      CheckUuidEvent event, Emitter<ExchangeState> emit) async {
    emit(CheckUuidLoading());
    final result = await exchageRepository.checkUuid(event);

    result.fold((failure) => emit(CheckUuidFailure(failure)), (success) {
      emit(CheckUuidSuccess(success));
    });
  }

  FutureOr<void> _handleExchangeInitEvent(
      ExchangeInitEvent event, Emitter<ExchangeState> emit) {
    emit(ExchangeInitial());
  }
}
