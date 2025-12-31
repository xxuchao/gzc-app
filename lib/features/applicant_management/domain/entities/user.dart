// #纯业务实体 (可不含 JSON 方法)

class User {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String orgName;
  final bool certification;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.orgName,
    required this.certification
  });
}