class UserModel {
  final String email;
  final String name;
  final String id;
  final String token;

  UserModel({this.email, this.name, this.id, this.token});
  Map<String, dynamic> toMap() {
    return {
      "token": token,
      "user": {
        "email": email,
        "name": name,
        "id": id,
      }
    };
  }

  UserModel.fromMap(Map<String, dynamic> fromMap)
      : email = fromMap["user"]["email"],
        name = fromMap["user"]["name"],
        id = fromMap["user"]["id"],
        token = fromMap["token"];
}
