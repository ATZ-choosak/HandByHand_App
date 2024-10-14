import 'package:hand_by_hand_app/data/models/user/user_model.dart';

class Item {
  final String title;
  final String description;
  final List<int> preferredCategoryIds;
  final List<ItemImage> images;
  final bool isExchangeable;
  final bool requireAllCategories;
  final Category category; // Category object
  final List<PreferredCategory> preferredCategory;
  final String address;
  final double lon;
  final double lat;
  final int id;
  final Owner owner;
  final DateTime createdAt;
  final DateTime updatedAt;

  Item(
      {required this.title,
      required this.description,
      required this.preferredCategoryIds,
      required this.images,
      required this.isExchangeable,
      required this.requireAllCategories,
      required this.category,
      required this.preferredCategory,
      required this.address,
      required this.lon,
      required this.lat,
      required this.id,
      required this.owner,
      required this.createdAt,
      required this.updatedAt});

  // Factory method to create an Item instance from JSON with snake_case keys
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      preferredCategoryIds: List<int>.from(json['preferred_category_ids']),
      images: json['images'] != null
          ? List<ItemImage>.from(
              json['images'].map((imageJson) => ItemImage.fromJson(imageJson)),
            )
          : [],
      isExchangeable: json['is_exchangeable'],
      requireAllCategories: json['require_all_categories'],
      category: Category.fromJson(json['category']),
      preferredCategory: json['preferred_category'] != null
          ? List<PreferredCategory>.from(json['preferred_category']
              .map((category) => PreferredCategory.fromJson(category)))
          : [], // Category object
      address: json['address'] ?? "",
      lon: json['lon'] ?? 0,
      lat: json['lat'] ?? 0,
      id: json['id'],
      owner: Owner.fromJson(json['owner']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class PreferredCategory {
  final int id;
  final String name;

  PreferredCategory({required this.id, required this.name});

  factory PreferredCategory.fromJson(Map<String, dynamic> json) {
    return PreferredCategory(id: json['id'], name: json['name']);
  }
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  // Factory method to create a Category instance from JSON with snake_case keys
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ItemImage {
  final String id;
  final String url;

  ItemImage({
    required this.id,
    required this.url,
  });

  // Factory method to create an Image instance from JSON with snake_case keys
  factory ItemImage.fromJson(Map<String, dynamic> json) {
    return ItemImage(
      id: json['id'],
      url: json['url'],
    );
  }
}

class Owner {
  final int id;
  final String name;
  final String phone;
  final ProfileImage? profileImage;

  Owner({
    required this.id,
    required this.name,
    required this.phone,
    required this.profileImage,
  });

  // Factory method to create an Owner instance from JSON with snake_case keys
  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'] ?? "",
      phone: json['phone'] ?? "",
      profileImage: json['profile_image'] != null
          ? ProfileImage.fromJson(json['profile_image'])
          : null,
    );
  }
}

class GetAllItemModel {
  final List<Item> items;
  final int totalItems, page, itemsPerPage, totalPages;

  GetAllItemModel(
      {required this.items,
      required this.totalItems,
      required this.page,
      required this.itemsPerPage,
      required this.totalPages});
  // Factory method to create GetAllItemModel instance from JSON with snake_case keys
  factory GetAllItemModel.fromJson(Map<String, dynamic> json) {
    return GetAllItemModel(
      items: List<Item>.from(
        json['items'].map((itemJson) => Item.fromJson(itemJson)),
      ),
      totalItems: json['total_items'],
      page: json['page'],
      itemsPerPage: json['items_per_page'],
      totalPages: json['total_pages'],
    );
  }
}

class GetAllMyItemModel {
  final List<Item> items;

  GetAllMyItemModel({
    required this.items,
  });

  factory GetAllMyItemModel.fromJson(List json) {
    return GetAllMyItemModel(
        items: List<Item>.from(
      json.map((itemJson) => Item.fromJson(itemJson)),
    ));
  }
}
