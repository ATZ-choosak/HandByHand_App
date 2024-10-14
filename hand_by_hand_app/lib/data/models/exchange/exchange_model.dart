import 'package:hand_by_hand_app/data/models/user/user_model.dart';

class ExchangeCheck {
  final String message;
  final bool canExchange;
  final List<MatchingItem> matchingItems;

  ExchangeCheck({
    required this.message,
    required this.canExchange,
    required this.matchingItems,
  });

  factory ExchangeCheck.fromJson(Map<String, dynamic> json) {
    return ExchangeCheck(
      message: json['message'] as String,
      canExchange: json['can_exchange'] as bool,
      matchingItems: json['matching_items'] != null
          ? (json['matching_items'] as List)
              .map((item) => MatchingItem.fromJson(item))
              .toList()
          : [],
    );
  }
}

class MatchingItem {
  final int id;
  final String name;
  final Category category;

  MatchingItem({
    required this.id,
    required this.name,
    required this.category,
  });

  factory MatchingItem.fromJson(Map<String, dynamic> json) {
    return MatchingItem(
      id: json['id'] as int,
      name: json['name'] as String,
      category: Category.fromJson(json['category']),
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

//InComing
class ExchangeInComing {
  final int requestedItemId;
  final int? offeredItemId;
  final int id;
  final String status;
  final String exchangeUuid;
  final EdItem requestedItem;
  final EdItem? offeredItem;
  final Requester requester;

  ExchangeInComing(
      {required this.requestedItemId,
      required this.offeredItemId,
      required this.id,
      required this.status,
      required this.exchangeUuid,
      required this.requestedItem,
      required this.offeredItem,
      required this.requester});

  factory ExchangeInComing.fromJson(Map<String, dynamic> json) {
    return ExchangeInComing(
        requestedItemId: json['requested_item_id'],
        offeredItemId: json['offered_item_id'],
        id: json['id'],
        status: json['status'],
        exchangeUuid: json['exchange_uuid'] ?? "",
        requestedItem: EdItem.fromJson(json['requested_item']),
        offeredItem: json['offered_item'] != null
            ? EdItem.fromJson(json['offered_item'])
            : null,
        requester: Requester.fromJson(json['requester']));
  }
}

//OutGoing
class ExchangeOutGoing {
  final int? requestedItemId;
  final int? offeredItemId;
  final int id;
  final String status;
  final String exchangeUuid;
  final EdItem requestedItem;
  final EdItem? offeredItem;
  final Owner owner;

  ExchangeOutGoing(
      {required this.requestedItemId,
      required this.offeredItemId,
      required this.id,
      required this.status,
      required this.exchangeUuid,
      required this.requestedItem,
      required this.offeredItem,
      required this.owner});

  factory ExchangeOutGoing.fromJson(Map<String, dynamic> json) {
    return ExchangeOutGoing(
        requestedItemId: json['requested_item_id'],
        offeredItemId: json['offered_item_id'],
        id: json['id'],
        status: json['status'],
        exchangeUuid: json['exchange_uuid'] ?? "",
        requestedItem: EdItem.fromJson(json['requested_item']),
        offeredItem: json['offered_item'] != null
            ? EdItem.fromJson(json['offered_item'])
            : null,
        owner: Owner.fromJson(json['owner']));
  }
}

class Owner {
  final int id;
  final String name;
  final String email;
  final ProfileImage? profileImage;

  Owner({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  // Factory method to create an Owner instance from JSON with snake_case keys
  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      profileImage: json['profile_image'] != null
          ? ProfileImage.fromJson(json['profile_image'])
          : null,
    );
  }
}

class Requester extends Owner {
  Requester(
      {required super.id,
      required super.name,
      required super.email,
      required super.profileImage});

  factory Requester.fromJson(Map<String, dynamic> json) {
    return Requester(
      id: json['id'],
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      profileImage: json['profile_image'] != null
          ? ProfileImage.fromJson(json['profile_image'])
          : null,
    );
  }
}

class EdItem {
  final int id;
  final String name;
  final String category;

  EdItem({
    required this.id,
    required this.name,
    required this.category,
  });

  factory EdItem.fromJson(Map<String, dynamic> json) {
    return EdItem(
      id: json['id'],
      name: json['name'],
      category: json['category'],
    );
  }
}
