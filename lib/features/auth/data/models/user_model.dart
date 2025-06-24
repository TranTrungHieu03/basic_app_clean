import 'dart:convert';

import 'package:store_demo/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.gender,
    required super.image,
    required super.accessToken,
    required super.refreshToken,
  });

  UserModel copyWith({
    int? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? accessToken,
    String? refreshToken,
  }) => UserModel(
    id: id ?? this.id,
    username: username ?? this.username,
    email: email ?? this.email,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    gender: gender ?? this.gender,
    image: image ?? this.image,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    gender: json["gender"],
    image: json["image"],
    accessToken: json["accessToken"] ?? "",
    refreshToken: json["refreshToken"] ?? "|",
  );

  static UserModel isEmpty() => UserModel(
    id: 0,
    username: "",
    email: "",
    firstName: "",
    lastName: '',
    gender: "",
    image: '',
    accessToken: "",
    refreshToken: "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "gender": gender,
    "image": image,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };

  static Map<String, dynamic> toMap(UserModel user) => {
    "id": user.id,
    "username": user.username,
    "email": user.email,
    "firstName": user.firstName,
    "lastName": user.lastName,
    "gender": user.gender,
    "image": user.image,
    "accessToken": user.accessToken,
    "refreshToken": user.refreshToken,
  };

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      image: image,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  static String serialize(UserModel model) =>
      json.encode(UserModel.toMap(model));

  static UserModel deserialize(String json) =>
      UserModel.fromJson(jsonDecode(json));
}
