import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/domain/repositories/my_item_repository.dart';
import 'package:meta/meta.dart';

part 'my_item_event.dart';
part 'my_item_state.dart';

class MyItemBloc extends Bloc<MyItemEvent, MyItemState> {
  final MyItemRepository myItemRepository;

  MyItemBloc({required this.myItemRepository}) : super(MyItemInitial()) {
    on<GetMyItemEvent>(_handleGetMyItemEvent);
    on<DeleteMyItemEvent>(_handleDeleteMyItemEvent);
  }

  Future<void> _handleGetMyItemEvent(
      GetMyItemEvent event, Emitter<MyItemState> emit) async {
    emit(GetMyItemLoading());
    final result = await myItemRepository.getMyItem();

    result.fold((failure) => emit(GetMyItemFailure(failure)), (success) {
      emit(GetMyItemSuccess(item: success));
    });
  }

  Future<void> _handleDeleteMyItemEvent(
      DeleteMyItemEvent event, Emitter<MyItemState> emit) async {
    emit(DeleteMyItemLoading());
    final result = await myItemRepository.deleteItem(event);

    result.fold((failure) => emit(DeleteMyItemFailure(failure)), (success) {
      emit(DeleteMyItemSuccess(success));
    });
  }
}
