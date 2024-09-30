import 'package:isar/isar.dart';

part 'author.g.dart'; // Required for code generation

// Constants for JSON keys related to Author
class AuthorJsonKeys {
  static const String idKey = 'id';
  static const String titleKey = 'title';
  static const String bodyKey = 'body';
  static const String imageKey = 'image';
  static const String limitKey = '_page';
  static const String pageKey = '_limit';
}

@collection
class Author {
  Id id = Isar.autoIncrement; // Primary key with auto increment

  late String? name;
  late String? desc;
  late String? image;

  Author({required this.id, this.name, this.image, this.desc});

  // Factory constructor to parse an Author from JSON
  factory Author.fromJson(Map<String, dynamic>? json) {
    return Author(
      id: json?[AuthorJsonKeys.idKey] ?? Isar.autoIncrement,
      name: json?[AuthorJsonKeys.titleKey] ?? '',
      desc: json?[AuthorJsonKeys.bodyKey] ?? '',
      image: json?[AuthorJsonKeys.imageKey] ?? '',
    );
  }

  // Static method to parse a list of Authors from JSON
  static List<Author> fromJsonList(List<dynamic> json) {
    // Return empty list if input is empty
    if (json.isEmpty) return [];

    // Map each item to an Author
    return json
        .map((item) => Author.fromJson(item as Map<String, dynamic>))
        .toList(); // Return the list of Authors
  }
}
