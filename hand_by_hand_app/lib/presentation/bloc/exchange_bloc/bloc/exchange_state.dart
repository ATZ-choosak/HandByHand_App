part of 'exchange_bloc.dart';

@immutable
sealed class ExchangeState {}

final class ExchangeInitial extends ExchangeState {}

final class CheckExchangeLoading extends ExchangeState {}

final class CheckEXchangeFailure extends ExchangeState {
  final String message;

  CheckEXchangeFailure(this.message);
}

final class CheckExchangeSuccess extends ExchangeState {
  final ExchangeCheck check;

  CheckExchangeSuccess({required this.check});
}

final class ExchangeInComingLoading extends ExchangeState {}

final class ExchangeInComingFailure extends ExchangeState {
  final String message;

  ExchangeInComingFailure(this.message);
}

final class ExchangeInComingSuccess extends ExchangeState {
  final List<ExchangeInComing> incoming;

  ExchangeInComingSuccess({required this.incoming});
}

final class ExchangeOutGoingLoading extends ExchangeState {}

final class ExchangeOutGoingFailure extends ExchangeState {
  final String message;

  ExchangeOutGoingFailure(this.message);
}

final class ExchangeOutGoingSuccess extends ExchangeState {
  final List<ExchangeOutGoing> outGoing;

  ExchangeOutGoingSuccess({required this.outGoing});
}

final class ExchangeRequestLoading extends ExchangeState {}

final class ExchangeRequestFailure extends ExchangeState {
  final String message;

  ExchangeRequestFailure(this.message);
}

final class ExchangeRequestSuccess extends ExchangeState {
  final String message;

  ExchangeRequestSuccess(this.message);
}

final class ExchangeAcceptLoading extends ExchangeState {}

final class ExchangeAcceptFailure extends ExchangeState {
  final String message;

  ExchangeAcceptFailure(this.message);
}

final class ExchangeAcceptSuccess extends ExchangeState {
  final String message;

  ExchangeAcceptSuccess(this.message);
}

final class ExchangeRejectLoading extends ExchangeState {}

final class ExchangeRejectFailure extends ExchangeState {
  final String message;

  ExchangeRejectFailure(this.message);
}

final class ExchangeRejectSuccess extends ExchangeState {
  final String message;

  ExchangeRejectSuccess(this.message);
}

final class CheckUuidLoading extends ExchangeState {}

final class CheckUuidFailure extends ExchangeState {
  final String message;

  CheckUuidFailure(this.message);
}

final class CheckUuidSuccess extends ExchangeState {
  final String message;

  CheckUuidSuccess(this.message);
}

