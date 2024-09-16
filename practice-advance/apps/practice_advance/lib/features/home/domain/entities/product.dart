import 'dart:core';

import 'package:isar/isar.dart';

part 'product.g.dart';

@collection
class Product {
  static const String keyId = 'id';
  static const String keyTitle = 'title';
  static const String keyDescription = 'description';
  static const String keyCategory = 'category';
  static const String keyPrice = 'price';
  static const String keyDiscountPercentage = 'discountPercentage';
  static const String keyRating = 'rating';
  static const String keyStock = 'stock';
  static const String keyTags = 'tags';
  static const String keyBrand = 'brand';
  static const String keySku = 'sku';
  static const String keyDimensions = 'dimensions';
  static const String keyDepth = 'depth';
  static const String keyWarrantyInformation = 'warrantyInformation';
  static const String keyShippingInformation = 'shippingInformation';
  static const String keyAvailabilityStatus = 'availabilityStatus';
  static const String keyReviews = 'reviews';
  static const String keyReturnPolicy = 'returnPolicy';
  static const String keyMinimumOrderQuantity = 'minimumOrderQuantity';
  static const String keyMeta = 'meta';
  static const String keyThumbnail = 'thumbnail';
  static const String keyImages = 'images';

  Id id = Isar.autoIncrement; // Auto-generate id

  late int productId;
  late String? title;
  late String? description;
  late String? category;
  late double? price;
  late double? discountPercentage;
  late double? rating;
  late int? stock;
  late List<String> tags;
  late String? brand;
  late String? sku;
  late double? depth;
  late String? warrantyInformation;
  late String? shippingInformation;
  late String? availabilityStatus;
  late List<Review> reviews;
  late String? returnPolicy;
  late int? minimumOrderQuantity;
  late MetaData? meta;
  late String? thumbnail;
  late List<String> images;

  Product({
    required this.productId,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags = const [],
    this.brand,
    this.sku,
    this.depth,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews = const [],
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.thumbnail,
    this.images = const [],
  });

  // Factory constructor to parse JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json[keyId] ?? 0,
      title: json[keyTitle] ?? '',
      description: json[keyDescription] ?? '',
      category: json[keyCategory] ?? '',
      price: json[keyPrice] ?? 0.0,
      discountPercentage: json[keyDiscountPercentage] ?? 0.0,
      rating: json[keyRating] ?? 0.0,
      stock: json[keyStock] ?? 0,
      tags: List<String>.from(json[keyTags] ?? []),
      brand: json[keyBrand] ?? '',
      sku: json[keySku] ?? '',
      depth: json[keyDimensions]?[keyDepth] ?? 0.0,
      warrantyInformation: json[keyWarrantyInformation] ?? '',
      shippingInformation: json[keyShippingInformation] ?? '',
      availabilityStatus: json[keyAvailabilityStatus] ?? '',
      reviews: (json[keyReviews] as List? ?? [])
          .map((r) => Review.fromJson(r))
          .toList(),
      returnPolicy: json[keyReturnPolicy] ?? '',
      minimumOrderQuantity: json[keyMinimumOrderQuantity] ?? 0,
      meta: MetaData.fromJson(json[keyMeta] ?? {}),
      thumbnail: json[keyThumbnail] ?? '',
      images: List<String>.from(json[keyImages] ?? []),
    );
  }
}

@embedded
class Review {
  static const String keyRating = 'rating';
  static const String keyComment = 'comment';
  static const String keyDate = 'date';
  static const String keyReviewerName = 'reviewerName';
  static const String keyReviewerEmail = 'reviewerEmail';

  late int rating;
  late String comment;
  late DateTime date;
  late String reviewerName;
  late String reviewerEmail;

  Review();
  // Factory constructor for Review
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review()
      ..rating = json[keyRating]
      ..comment = json[keyComment]
      ..date = DateTime.parse(json[keyDate])
      ..reviewerName = json[keyReviewerName]
      ..reviewerEmail = json[keyReviewerEmail];
  }
}

@embedded
class MetaData {
  static const String keyCreatedAt = 'createdAt';
  static const String keyUpdatedAt = 'updatedAt';
  static const String keyBarcode = 'barcode';
  static const String keyQrCode = 'qrCode';

  late DateTime createdAt;
  late DateTime updatedAt;
  late String barcode;
  late String qrCode;

  MetaData();
  // Factory constructor for MetaData
  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData()
      ..createdAt = DateTime.parse(json[keyCreatedAt])
      ..updatedAt = DateTime.parse(json[keyUpdatedAt])
      ..barcode = json[keyBarcode]
      ..qrCode = json[keyQrCode];
  }
}
