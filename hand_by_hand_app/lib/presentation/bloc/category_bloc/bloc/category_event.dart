part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class CategoryLoadingEvent extends CategoryEvent {}

class CategorySelectEvent extends CategoryEvent {
  final int id;

  CategorySelectEvent({required this.id});
}

class CategorySubmitEvent extends CategoryEvent {}
