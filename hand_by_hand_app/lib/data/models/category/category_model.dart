import 'dart:convert';

class CategoryModel {
  final int id;
  final String title;
  final CategoryImage image;

  CategoryModel({required this.title, required this.image, required this.id});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['name'],
      image: json['image'].map((category) => CategoryImage.fromJson(category)),
      id: json['id'],
    );
  }
}

class CategoryImage {
  final String id;
  final String url;

  CategoryImage({required this.id, required this.url});

  factory CategoryImage.fromJson(Map<String, dynamic> json) {
    return CategoryImage(id: json['id'], url: json['url']);
  }
}

class CategoryInterestingInput {
  List<int> categorys = [];

  addtoList(int id) {
    categorys.add(id);
  }

  Object toJson() {
    return jsonEncode(categorys);
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
      image: CategoryImage.fromJson(json['image']),
      id: json['id'],
      selected: false,
    );
  }
}
