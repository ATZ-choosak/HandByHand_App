class UserGetMe {
  final String email;
  final String phone;
  final String address;
  final double lon;
  final double lat;
  final ProfileImage? profileImage;
  final int id;
  final String name;
  final bool isVerified;
  final bool isFirstLogin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int postCount, exchangeCompleteCount;
  final double rating;

  UserGetMe(
      {required this.email,
      required this.phone,
      required this.address,
      required this.lon,
      required this.lat,
      required this.profileImage,
      required this.id,
      required this.name,
      required this.isVerified,
      required this.isFirstLogin,
      required this.createdAt,
      required this.updatedAt,
      required this.postCount,
      required this.exchangeCompleteCount,
      required this.rating});

  // Factory method to create a UserGetMe instance from JSON
  factory UserGetMe.fromJson(Map<String, dynamic> json) {
    return UserGetMe(
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      lon: json['lon']?.toDouble(),
      lat: json['lat']?.toDouble(),
      profileImage: json['profile_image'] != null
          ? ProfileImage.fromJson(json['profile_image'])
          : null,
      id: json['id'],
      name: json['name'],
      isVerified: json['is_verified'],
      isFirstLogin: json['is_first_login'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      postCount: json['post_count'],
      exchangeCompleteCount: json['exchange_complete_count'],
      rating: json['rating'],
    );
  }
}

class ProfileImage {
  final String id;
  final String url;

  ProfileImage({
    required this.id,
    required this.url,
  });

  // Factory method to create a ProfileImage instance from JSON
  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      id: json['id'],
      url: json['url'],
    );
  }
}
