import 'package:isar/isar.dart';

part 'vendor.g.dart'; // Required for code generation

@collection
class Vendor {
  Id id = Isar.autoIncrement; // Primary key with auto increment

  late String? name;
  late String? image;
  late double? rating;

  Vendor({required this.id, this.name, this.image, this.rating});

  // Factory constructor to parse from JSON
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] ?? Isar.autoIncrement,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      rating: double.tryParse(json['rating'].toString()),
    );
  }

  // Static method to parse a list of Vendors
  static List<Vendor> fromJsonList(Map<String, dynamic> json) {
    if (json.isEmpty) return [];

    var jsonList = json['recipes'] as List<dynamic>;

    return jsonList
        .map((json) => Vendor.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
