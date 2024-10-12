part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryFailure extends CategoryState {
  final String message;

  CategoryFailure(this.message);
}

final class CategorySuccess extends CategoryState {
  final List<CategorySelectedModel> categorys;

  CategorySuccess(this.categorys);
}

final class CategorySubmitLoading extends CategoryState {}

final class CategorySubmitSuccess extends CategorySuccess {
  CategorySubmitSuccess(super.categorys);
}

final class CategorySubmitFailure extends CategoryState {
  final String message;

  CategorySubmitFailure(this.message);
}
