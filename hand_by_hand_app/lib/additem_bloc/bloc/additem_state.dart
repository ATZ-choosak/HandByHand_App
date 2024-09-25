part of 'additem_bloc.dart';

@immutable
sealed class AdditemState {}

final class AdditemInitial extends AdditemState {}

final class AddImagesLoading extends AdditemState {}

final class AddImagesSuccess extends AdditemState {
  final List<File> images;
  AddImagesSuccess({required this.images});
}

final class AddImagesFailure extends AdditemState {
  final String message;
  final List<File> images;

  AddImagesFailure({required this.message, required this.images});
}
