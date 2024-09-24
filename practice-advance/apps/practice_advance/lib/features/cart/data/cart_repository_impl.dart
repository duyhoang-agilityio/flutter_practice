import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:isar/isar.dart';
import 'package:practice_advance/features/cart/domain/entities/cart_item.dart';

class CartService {
  late Isar isar;

  CartService() {
    _initIsar();
  }

  Future<void> _initIsar() async {
    isar = await Isar.open([CartItemSchema], directory: '');
  }

  Future<void> addItemToCart(CartItem item) async {
    await isar.writeTxn(() async {
      await isar.cartItems.put(item); // Adds or updates item
    });
  }

  Future<List<CartItem>> getCartItems() async {
    return await isar.cartItems.where().findAll(); // Retrieves all cart items
  }

  Future<void> updateItemQuantity(int productId, int newQuantity) async {
    final item = await isar.cartItems.filter().productIdEqualTo(productId).findFirst();
    if (item != null) {
      item.quantity = newQuantity;
      await isar.writeTxn(() async {
        await isar.cartItems.put(item);
      });
    }
  }

  Future<void> deleteItem(int productId) async {
    await isar.writeTxn(() async {
      await isar.cartItems.filter().productIdEqualTo(productId).deleteFirst();
    });
  }
}


// Create an instance of CartService for managing Isar operations
final CartService cartService = CartService();

// Define a mutation to add a product to the cart
final addToCartMutation = Mutation<CartItem, CartItem>(
  // This is the function that will be called when the mutation is triggered
  queryFn: (cartItem) async {
    await cartService.addItemToCart(cartItem); // Add item to Isar DB
    return cartItem;
  },
  // Invalidate all queries that are related to the cart to ensure the data stays fresh
  invalidateQueries: ['cartItems'],
  // Refetch queries to update the cart data in real time
  refetchQueries: ['cartItems'],
);