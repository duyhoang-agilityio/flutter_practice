import 'package:isar/isar.dart';

part 'author.g.dart'; // Required for code generation

@collection
class Author {
  Id id = Isar.autoIncrement; // Primary key with auto increment

  late String? name;
  late String? desc;
  late String? image;

  Author({required this.id, this.name, this.image, this.desc});

  // Factory constructor to parse from JSON
  factory Author.fromJson(Map<String, dynamic>? json) {
    return Author(
      id: json?['id'] ?? Isar.autoIncrement,
      name: json?['title'] ?? '',
      desc: json?['body'] ?? '',
      image: json?['image'] ?? '',
    );
  }

  // Static method to parse a list of Authors
  static List<Author> fromJsonList(List<dynamic> json) {
    if (json.isEmpty) return [];

    return json
        .map((item) => Author.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
