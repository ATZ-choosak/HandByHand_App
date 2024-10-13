part of 'my_item_bloc.dart';

@immutable
sealed class MyItemState {}

final class MyItemInitial extends MyItemState {}

final class GetMyItemLoading extends MyItemState {}

final class GetMyItemFailure extends MyItemState {
  final String message;

  GetMyItemFailure(this.message);
}

final class GetMyItemSuccess extends MyItemState {
  final GetAllMyItemModel item;

  GetMyItemSuccess({required this.item});
}

final class DeleteMyItemLoading extends MyItemState {}

final class DeleteMyItemFailure extends MyItemState {
  final String message;

  DeleteMyItemFailure(this.message);
}

final class DeleteMyItemSuccess extends MyItemState {
  final String message;

  DeleteMyItemSuccess(this.message);
}
