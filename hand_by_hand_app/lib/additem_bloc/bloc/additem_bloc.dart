import 'package:bloc/bloc.dart';
import 'package:hand_by_hand_app/api/category/category_model.dart';
import 'package:meta/meta.dart';

part 'additem_event.dart';
part 'additem_state.dart';

class AdditemBloc extends Bloc<AdditemEvent, AdditemState> {
  final List<CategorySelectedModel> categorysType;
  final List<CategorySelectedModel> categorysRequire;

  AdditemBloc(this.categorysType, this.categorysRequire)
      : super(AdditemInitial()) {
    on<AddImageEvent>(_handleAddImagesEvent);
  }

  Future<void> _handleAddImagesEvent(
      AddImageEvent event, Emitter<AdditemState> emit) async {}

}
