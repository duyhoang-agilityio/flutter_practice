import 'package:isar/isar.dart';

part 'vendor.g.dart'; // Required for code generation

// Constants for JSON keys related to Vendor
class VendorJsonKeys {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String ingredientsKey = 'ingredients';
  static const String instructionsKey = 'instructions';
  static const String prepTimeMinutesKey = 'prepTimeMinutes';
  static const String cookTimeMinutesKey = 'cookTimeMinutes';
  static const String servingsKey = 'servings';
  static const String difficultyKey = 'difficulty';
  static const String cuisineKey = 'cuisine';
  static const String caloriesPerServingKey = 'caloriesPerServing';
  static const String tagsKey = 'tags';
  static const String userIdKey = 'userId';
  static const String imageKey = 'image';
  static const String ratingKey = 'rating';
  static const String reviewCountKey = 'reviewCount';
  static const String mealTypeKey = 'mealType';
}

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
      vendorId: json[VendorJsonKeys.idKey] ?? Isar.autoIncrement, //
      name: json[VendorJsonKeys.nameKey] ?? '',
      ingredients: List<String>.from(json[VendorJsonKeys.ingredientsKey] ?? []),
      instructions:
          List<String>.from(json[VendorJsonKeys.instructionsKey] ?? []),
      prepTimeMinutes: json[VendorJsonKeys.prepTimeMinutesKey] ?? 0,
      cookTimeMinutes: json[VendorJsonKeys.cookTimeMinutesKey] ?? 0,
      servings: json[VendorJsonKeys.servingsKey] ?? 0,
      difficulty: json[VendorJsonKeys.difficultyKey] ?? '',
      cuisine: json[VendorJsonKeys.cuisineKey] ?? '',
      price: json[VendorJsonKeys.caloriesPerServingKey] ?? 0,
      tags: List<String>.from(json[VendorJsonKeys.tagsKey] ?? []),
      userId: json[VendorJsonKeys.userIdKey] ?? 0,
      image: json[VendorJsonKeys.imageKey] ?? '',
      rating: double.tryParse(json[VendorJsonKeys.ratingKey].toString()) ?? 0.0,
      reviewCount: json[VendorJsonKeys.reviewCountKey] ?? 0,
      mealType: List<String>.from(json[VendorJsonKeys.mealTypeKey] ?? []),
      quantity: 5,
    );
  }

  // Static method to parse a list of Vendors
  static List<Vendor> fromJsonList(List<dynamic> json) {
    // Return an empty list if input is empty
    if (json.isEmpty) return [];

    // Map each item to a Vendor
    return json.map((json) => Vendor.fromJson(json)).toList();
  }

  // Method to format product price and format price as a string
  String productPrice(int price) => '\$${(price - 0.01).toStringAsFixed(2)}';
}

// List of tags related to vendors
final List<String> tags = [
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
