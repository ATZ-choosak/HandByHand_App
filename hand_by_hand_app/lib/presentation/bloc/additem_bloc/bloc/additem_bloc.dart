import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'additem_event.dart';
part 'additem_state.dart';

class AdditemBloc extends Bloc<AdditemEvent, AdditemState> {
  final ImagePicker picker = ImagePicker();

  final List<CategorySelectedModel> categorysType;
  final List<CategorySelectedModel> categorysRequire;
  List<File> images = [];

  AdditemBloc(this.categorysType, this.categorysRequire)
      : super(AdditemInitial()) {
    on<AddImageEvent>(_handleAddImagesEvent);
    on<RemoveImageEvent>(_handleRemoveImagesEvent);
  }

  Future<void> _handleRemoveImagesEvent(
      RemoveImageEvent event, Emitter<AdditemState> emit) async {
    images.remove(event.image);
    emit(AddImagesLoading());
    emit(AddImagesSuccess(images: images));
  }

  Future<void> _handleAddImagesEvent(
      AddImageEvent event, Emitter<AdditemState> emit) async {
    final List<XFile> allImage = await picker.pickMultiImage();

    if (allImage.length > 6) {
      emit(AddImagesFailure(
          message: "กรุณาเลือกรูปภาพไม่เกิน 6 รูป", images: images));
      return;
    }

    if ((images.length + allImage.length) > 6) {
      emit(AddImagesFailure(
          message: "รูปครบจำนวนแล้ว ลบบางรูปเพื่อแก้ไข",
          images: images));
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
}
