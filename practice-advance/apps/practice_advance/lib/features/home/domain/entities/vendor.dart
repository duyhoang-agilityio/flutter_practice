import 'package:isar/isar.dart';

part 'vendor.g.dart'; // Required for code generation

@collection
class Vendor {
  Id id = Isar.autoIncrement; // Primary key with auto increment

  final int vendorId;
  final String? name;
  final List<String>? ingredients;
  final List<String>? instructions;
  final int? prepTimeMinutes;
  final int? cookTimeMinutes;
  final int? servings;
  final String? difficulty;
  final String? cuisine;
  final int? price;
  final List<String>? tags;
  final int? userId;
  final String? image;
  final double? rating;
  final int? quantity;
  final int? reviewCount;
  final List<String>? mealType;

  Vendor({
    required this.vendorId,
    this.name,
    this.ingredients,
    this.instructions,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.servings,
    this.difficulty,
    this.cuisine,
    this.price,
    this.tags,
    this.userId,
    this.image,
    this.rating,
    this.quantity,
    this.reviewCount,
    this.mealType,
  });

  // Factory constructor to parse from JSON
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorId: json['id'] ?? Isar.autoIncrement,
      name: json['name'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      prepTimeMinutes: json['prepTimeMinutes'] ?? 0,
      cookTimeMinutes: json['cookTimeMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
      difficulty: json['difficulty'] ?? '',
      cuisine: json['cuisine'] ?? '',
      price: json['caloriesPerServing'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      userId: json['userId'] ?? 0,
      image: json['image'] ?? '',
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      mealType: List<String>.from(json['mealType'] ?? []),
      quantity: 5,
    );
  }

  // Static method to parse a list of Vendors
  static List<Vendor> fromJsonList(List<dynamic> json) {
    if (json.isEmpty) return [];

    return json.map((json) => Vendor.fromJson(json)).toList();
  }

  String productPrice(int price) => '\$${(price - 0.01).toStringAsFixed(2)}';
}

final tags = [
  "Pizza",
  "Italian",
  "Vegetarian",
  "Stir-fry",
  "Asian",
  "Cookies",
  "Dessert",
  "Baking",
  "Pasta",
  "Chicken",
  "Salsa",
  "Salad",
  "Quinoa",
  "Bruschetta",
  "Beef",
  "Caprese",
  "Shrimp",
  "Biryani",
  "Main course",
  "Indian",
  "Pakistani",
  "Karahi",
  "Keema",
];
