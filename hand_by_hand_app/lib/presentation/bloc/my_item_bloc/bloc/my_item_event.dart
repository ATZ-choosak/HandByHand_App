part of 'my_item_bloc.dart';

@immutable
sealed class MyItemEvent {}

class GetMyItemEvent extends MyItemEvent {}

class DeleteMyItemEvent extends MyItemEvent {
  final int id;

  DeleteMyItemEvent({required this.id});
}
