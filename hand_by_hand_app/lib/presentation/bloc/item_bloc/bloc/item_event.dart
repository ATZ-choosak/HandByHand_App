part of 'item_bloc.dart';

@immutable
sealed class ItemEventBase {}

class ItemInitalEvent extends ItemEventBase {}

class GetItemEvent extends ItemEventBase {
  final int page, itemPerPage;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"page": page, "items_per_page": itemPerPage};
  }

  GetItemEvent({required this.page, required this.itemPerPage});
}

class SearchItemEvent extends ItemEventBase {
  final String query;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"query": query};
  }

  SearchItemEvent({required this.query});
}

class AddImageEvent extends ItemEventBase {}

class RemoveImageEvent extends ItemEventBase {
  final File image;
  RemoveImageEvent({required this.image});
}

class AddItemEvent extends ItemEventBase {
  final String title;
  final String description;
  final int categoryId;
  final List<int> preferredCategoryIds;
  final bool isExchangeable;
  final bool requireAllCategories;
  final String address;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "title": title,
      "description": description,
      "category_id": categoryId,
      "preferred_category_ids":
          preferredCategoryIds.isNotEmpty ? preferredCategoryIds.join(',') : "",
      "is_exchangeable": isExchangeable,
      "require_all_categories": requireAllCategories,
      "address": address,
    };
  }

  AddItemEvent(
      {required this.title,
      required this.description,
      required this.categoryId,
      required this.preferredCategoryIds,
      required this.isExchangeable,
      required this.requireAllCategories,
      required this.address});
}
