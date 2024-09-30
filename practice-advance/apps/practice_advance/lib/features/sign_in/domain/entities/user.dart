// user_model.dart
import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement;

  String username;
  String email;
  String token;

  User({required this.username, required this.email, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }
}
