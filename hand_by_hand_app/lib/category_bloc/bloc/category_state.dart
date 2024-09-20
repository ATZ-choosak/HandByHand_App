part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final List<CategorySelectedModel> categorys;

  CategorySuccess({required this.categorys});
}

final class CategorySubmitSuccess extends CategorySuccess {
  CategorySubmitSuccess({required super.categorys});
}
