import 'package:hand_by_hand_app/data/models/category/category_model.dart';

class CategoryMockup {
  List<CategorySelectedModel> getCategory() {
    return [
      CategorySelectedModel(
          id: 1,
          title: "เครื่องแต่งกายและแฟชั่น",
          image: CategoryImage(id: "1", url: "images/category/fashion.jpg"),
          selected: false),
    ];
  }
}
