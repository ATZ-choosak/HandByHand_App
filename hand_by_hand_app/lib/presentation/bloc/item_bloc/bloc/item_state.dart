part of 'item_bloc.dart';

@immutable
sealed class ItemState {}

final class AdditemInitial extends ItemState {}

final class AddImagesLoading extends ItemState {}

final class AddImagesSuccess extends ItemState {
  final List<File> images;
  AddImagesSuccess({required this.images});
}

final class AddImagesFailure extends ItemState {
  final String message;
  final List<File> images;

  AddImagesFailure({required this.message, required this.images});
}

final class AdditemLoading extends ItemState {}

final class AdditemSuccess extends ItemState {
  final String message;

  AdditemSuccess(this.message);
}

final class AdditemFailure extends ItemState {
  final String message;

  AdditemFailure(this.message);
}

final class AdditemInitalLoading extends ItemState {}

final class AdditemInitalSuccess extends ItemState {
  final List<CategorySelectedModel> categorys;

  AdditemInitalSuccess({required this.categorys});
}

final class AdditemInitalFailure extends ItemState {
  final String message;

  AdditemInitalFailure(this.message);
}

final class GetItemLoading extends ItemState {}

final class GetItemFailure extends ItemState {
  final String message;

  GetItemFailure(this.message);
}

final class GetItemSuccess extends ItemState {
  final GetAllItemModel allItems;

  GetItemSuccess({required this.allItems});
}

