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
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? Isar.autoIncrement,
      name: json['author'] ?? '',
      desc: json['quote'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // Static method to parse a list of Authors
  static List<Author> fromJsonList(Map<String, dynamic> json) {
    if (json.isEmpty) return [];

    var jsonList = json['quotes'] as List<dynamic>;

    return jsonList
        .map((json) => Author.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
