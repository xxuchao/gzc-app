// JSON  Dart (含 fromJson/toJson)
import 'package:gzc_app/features/auth/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part "user_model.g.dart";

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String orgName;
  final bool certification;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.orgName,
    required this.certification
  });

  User toEntity(){
    return User(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      orgName: orgName,
      certification: certification
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}