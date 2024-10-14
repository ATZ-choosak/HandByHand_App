// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';
import 'package:hand_by_hand_app/data/models/item/item_model.dart';
import 'package:hand_by_hand_app/domain/repositories/category_repository.dart';
import 'package:hand_by_hand_app/domain/repositories/item_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEventBase, ItemState> {
  final ItemRepository itemRepository;
  final CategoryRepository categoryRepository;

  final ImagePicker picker = ImagePicker();

  List<CategorySelectedModel> categorys = [];

  List<File> images = [];

  ItemBloc({required this.itemRepository, required this.categoryRepository})
      : super(AdditemInitial()) {
    on<AddImageEvent>(_handleAddImagesEvent);
    on<RemoveImageEvent>(_handleRemoveImagesEvent);
    on<AddItemEvent>(_handleAddItemEvent);
    on<UpdateItemEvent>(_handleUpdateItemEvent);
    on<ItemInitalEvent>(_handleItemInitalEvent);
    on<GetItemEvent>(_handleGetItemEvent);
    on<GetItemByIdEvent>(_handleGetItemByIdEvent);
    on<SearchItemEvent>(_handleSearchItemEvent);
  }

  Future<void> _handleItemInitalEvent(
      ItemInitalEvent event, Emitter<ItemState> emit) async {
    emit(AdditemInitalLoading());
    final result = await categoryRepository.getCategories();

    result.fold((failure) => emit(AdditemInitalFailure(failure)), (success) {
      categorys = success;
      emit(AdditemInitalSuccess(categorys: success));
    });
  }

  Future<void> _handleRemoveImagesEvent(
      RemoveImageEvent event, Emitter<ItemState> emit) async {
    images.remove(event.image);
    emit(AddImagesLoading());
    emit(AddImagesSuccess(images: images));
  }

  Future<void> _handleAddItemEvent(
      AddItemEvent event, Emitter<ItemState> emit) async {
    emit(AdditemLoading());
    final result = await itemRepository.addItem(event, images);

    result.fold((failure) => emit(AdditemFailure(failure)), (success) {
      emit(AdditemSuccess(success));
      images = [];
    });
  }

  Future<void> _handleUpdateItemEvent(
      UpdateItemEvent event, Emitter<ItemState> emit) async {
    emit(AdditemLoading());
    final result = await itemRepository.updateItem(event, images);

    result.fold((failure) => emit(AdditemFailure(failure)),
        (success) => emit(AdditemSuccess(success)));
  }

  Future<void> _handleAddImagesEvent(
      AddImageEvent event, Emitter<ItemState> emit) async {
    final List<XFile> allImage = await picker.pickMultiImage();

    if (allImage.length > 6) {
      emit(AddImagesFailure(
          message: "กรุณาเลือกรูปภาพไม่เกิน 6 รูป", images: images));
      return;
    }

    if ((images.length + allImage.length) > 6) {
      emit(AddImagesFailure(
          message: "รูปครบจำนวนแล้ว ลบบางรูปเพื่อแก้ไข", images: images));
      return;
    }

    images += allImage
        .map(
          (e) => File(e.path),
        )
        .toList();

    emit(AddImagesLoading());
    emit(AddImagesSuccess(images: images));
  }

  //GetItem
  Future<void> _handleGetItemEvent(
      GetItemEvent event, Emitter<ItemState> emit) async {
    emit(GetItemLoading());

    final result = await itemRepository.getItem(event, null);

    result.fold((failure) => emit(GetItemFailure(failure)), (success) {
      emit(GetItemSuccess(allItems: success));
    });
  }

   Future<void> _handleGetItemByIdEvent(
      GetItemByIdEvent event, Emitter<ItemState> emit) async {
    emit(GetItemLoading());

    final result = await itemRepository.getItemById(event);

    result.fold((failure) => emit(GetItemFailure(failure)), (success) {
      emit(GetItemByIdSuccess(item: success));
    });
  }

  //SearchItem
  Future<void> _handleSearchItemEvent(
      SearchItemEvent event, Emitter<ItemState> emit) async {
    emit(GetItemLoading());

    final result = await itemRepository.getItem(
        GetItemEvent(page: 1, itemPerPage: 10), event.query);

    result.fold((failure) => emit(GetItemFailure(failure)), (success) {
      emit(SearchItemSuccess(allItems: success));
    });
  }
}
