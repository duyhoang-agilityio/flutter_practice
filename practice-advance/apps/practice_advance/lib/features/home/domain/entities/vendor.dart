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

  late int vendorId;
  late String? name;
  late List<String>? ingredients;
  late List<String>? instructions;
  late int? prepTimeMinutes;
  late int? cookTimeMinutes;
  late int? servings;
  late String? difficulty;
  late String? cuisine;
  late double? price;
  late List<String>? tags;
  late int? userId;
  late String? image;
  late double? rating;
  late int? quantity;
  late int? reviewCount;
  late int? inStock;
  late List<String>? mealType;

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
    this.inStock,
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
      price: (json[VendorJsonKeys.caloriesPerServingKey] ?? 0).toDouble(),
      tags: List<String>.from(json[VendorJsonKeys.tagsKey] ?? []),
      userId: json[VendorJsonKeys.userIdKey] ?? 0,
      image: json[VendorJsonKeys.imageKey] ?? '',
      rating: double.tryParse(json[VendorJsonKeys.ratingKey].toString()) ?? 0.0,
      reviewCount: json[VendorJsonKeys.reviewCountKey] ?? 0,
      mealType: List<String>.from(json[VendorJsonKeys.mealTypeKey] ?? []),
      quantity: 1,
      inStock: 5,
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
  String productPrice(double price, int quantity) =>
      '\$${((price - 0.01) * quantity).toStringAsFixed(2)}';

  String get desc => '${instructions?[4] ?? ''} ${instructions?[3] ?? ''}';

  // CopyWith method
  Vendor copyWith({
    int? vendorId,
    String? name,
    List<String>? ingredients,
    List<String>? instructions,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    int? servings,
    String? difficulty,
    String? cuisine,
    double? price,
    List<String>? tags,
    int? userId,
    String? image,
    double? rating,
    int? quantity,
    int? reviewCount,
    int? inStock,
    List<String>? mealType,
  }) {
    return Vendor(
      vendorId: vendorId ?? this.vendorId,
      name: name ?? this.name,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      cuisine: cuisine ?? this.cuisine,
      price: price ?? this.price,
      tags: tags ?? this.tags,
      userId: userId ?? this.userId,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
      inStock: inStock ?? this.inStock,
      reviewCount: reviewCount ?? this.reviewCount,
      mealType: mealType ?? this.mealType,
    );
  }
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
