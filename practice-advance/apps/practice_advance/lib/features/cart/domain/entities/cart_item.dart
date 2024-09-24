import 'package:isar/isar.dart';

part 'cart_item.g.dart'; // Required for Isar model generation

@Collection()
class CartItem {
  Id id = Isar.autoIncrement;
  late int productId;
  late String productName;
  late int quantity;
  late double price;
  
  CartItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });
}