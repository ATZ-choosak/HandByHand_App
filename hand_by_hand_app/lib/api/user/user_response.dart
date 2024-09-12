class UserResponse {
  String email;
  String name;
  int id;

  UserResponse(this.email, this.name, this.id);

  factory UserResponse.fromJson(Map<String, dynamic> map) {
    return UserResponse(map["email"], map["name"], map["id"]);
  }
}
