// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:hand_by_hand_app/data/models/category/category_model.dart';
import 'package:hand_by_hand_app/domain/repositories/category_repository.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  List<CategorySelectedModel> categorys = [];

  CategoryBloc({required this.categoryRepository}) : super(CategoryInitial()) {
    on<CategoryLoadingEvent>(_handleCategoryLoadingEvent);
    on<CategorySelectEvent>(_handleCategorySelectedEvent);
    on<CategorySubmitEvent>(_handleCategorySubmitEvent);
  }

  Future<void> _handleCategoryLoadingEvent(
      CategoryLoadingEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    final result = await categoryRepository.getCategories();

    result.fold((failure) => emit(CategoryFailure(failure)), (success) {
      categorys = success;
      emit(CategorySuccess(success));
    });
  }

  Future<void> _handleCategorySelectedEvent(
      CategorySelectEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    CategorySelectedModel category = categorys.firstWhere(
      (element) => element.id == event.id,
    );
    category.selected = !category.selected;
    emit(CategorySuccess(categorys));
  }

  Future<void> _handleCategorySubmitEvent(
      CategorySubmitEvent event, Emitter<CategoryState> emit) async {
    for (var element in categorys) {
      if (element.selected) {
        print("${element.title} : ${element.id}");
      }
    }

    emit(CategorySubmitSuccess(categorys));
  }
}
