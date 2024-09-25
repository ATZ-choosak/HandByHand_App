// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final List<CategorySelectedModel> categorys;

  CategoryBloc(this.categorys) : super(CategoryInitial()) {
    on<CategoryLoadingEvent>(_handleCategoryLoadingEvent);
    on<CategorySelectEvent>(_handleCategorySelectedEvent);
    on<CategorySubmitEvent>(_handleCategorySubmitEvent);
  }

  Future<void> _handleCategoryLoadingEvent(
      CategoryLoadingEvent event, Emitter<CategoryState> emit) async {
    await Future.delayed(const Duration(seconds: 1));

    emit(CategorySuccess(categorys: categorys));
  }

  Future<void> _handleCategorySelectedEvent(
      CategorySelectEvent event, Emitter<CategoryState> emit) async {
    CategorySelectedModel select =
        categorys.firstWhere((element) => element.id == event.id);
    select.selected = !select.selected;
    emit(CategorySuccess(categorys: categorys));
  }

  Future<void> _handleCategorySubmitEvent(
      CategorySubmitEvent event, Emitter<CategoryState> emit) async {
    for (var i = 0; i < categorys.length; i++) {
      if (categorys[i].selected) {
        print(categorys[i].title);
      }
    }
      emit(CategorySubmitSuccess(categorys: categorys));
  }
}
