class CategoryModel {
  final int id;
  final String title;
  final String image;

  CategoryModel({required this.title, required this.image, required this.id});
}

class CategorySelectedModel extends CategoryModel {
  bool selected;

  CategorySelectedModel(
      {required super.title,
      required super.image,
      required this.selected,
      required super.id});
}
