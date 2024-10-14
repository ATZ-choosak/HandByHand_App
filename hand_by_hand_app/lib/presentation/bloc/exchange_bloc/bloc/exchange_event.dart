part of 'exchange_bloc.dart';

@immutable
sealed class ExchangeEvent {}

class ExchangeInitEvent extends ExchangeEvent {}

class CheckRequestExchangeEvent extends ExchangeEvent {
  final int requestedItemId;

  CheckRequestExchangeEvent({required this.requestedItemId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "requested_item_id": requestedItemId,
    };
  }
}

class ExchangeAcceptEvent extends ExchangeEvent {
  final int exchangeId;

  ExchangeAcceptEvent({required this.exchangeId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "exchange_id": exchangeId,
    };
  }
}

class ExchangeRejectEvent extends ExchangeEvent {
  final int exchangeId;

  ExchangeRejectEvent({required this.exchangeId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "exchange_id": exchangeId,
    };
  }
}

class ExchageRequestEvent extends ExchangeEvent {
  final int requestedItemId;
  final int? offeredItemId;

  ExchageRequestEvent(
      {required this.requestedItemId, required this.offeredItemId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "requested_item_id": requestedItemId,
      "offered_item_id": offeredItemId
    };
  }
}

class CheckUuidEvent extends ExchangeEvent {
  final int exchangeId;
  final String exchangeUuid;

  CheckUuidEvent(
      {required this.exchangeId, required this.exchangeUuid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "exchange_id": exchangeId,
      "exchange_uuid": exchangeUuid
    };
  }
}

class ExchangeInComingEvent extends ExchangeEvent {}

class ExchangeOutgoingEvent extends ExchangeEvent {}
