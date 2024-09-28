class CategoryModel {
  final int id;
  final String title;
  final String image;

  CategoryModel({required this.title, required this.image, required this.id});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['name'],
      image: json['image_url'] ?? "",
      id: json['id'],
    );
  }
}

class CategorySelectedModel extends CategoryModel {
  bool selected;

  CategorySelectedModel({
    required super.title,
    required super.image,
    required this.selected,
    required super.id,
  });

  factory CategorySelectedModel.fromJson(Map<String, dynamic> json) {
    return CategorySelectedModel(
      title: json['name'],
      image: json['image_url'] ?? "",
      id: json['id'],
      selected: false,
    );
  }
}
