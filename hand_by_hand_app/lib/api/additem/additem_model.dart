import 'package:hand_by_hand_app/api/category/category_model.dart';

class ItemImage {
  final int id;

  ItemImage({required this.id});
}

class AdditemModel {
  final List<ItemImage> image;
  final String name;
  final String position;
  final String description;
  final CategorySelectedModel categoryType;
  final List<CategorySelectedModel> categorysRequire;

  AdditemModel(
      {required this.image,
      required this.name,
      required this.position,
      required this.description,
      required this.categoryType,
      required this.categorysRequire});
}
