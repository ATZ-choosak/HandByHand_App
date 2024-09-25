part of 'additem_bloc.dart';

@immutable
sealed class AdditemEvent {}

class AddImageEvent extends AdditemEvent {}

class RemoveImageEvent extends AdditemEvent {
  final File image;
  RemoveImageEvent({required this.image});
}
