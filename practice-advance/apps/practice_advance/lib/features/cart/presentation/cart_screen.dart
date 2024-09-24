import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/cart/domain/entities/cart_item.dart';
import 'package:practice_advance/features/cart/presentation/bloc/cart_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;
  final String productName;
  final double productPrice;

  const ProductDetailPage({
    super.key,
    required this.productId,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Price: \$$productPrice'),
            ElevatedButton(
              onPressed: () {
                // Trigger the AddToCartEvent to add the product to the cart
                final cartItem = CartItem(
                  productId: productId,
                  productName: productName,
                  quantity: 1,
                  price: productPrice,
                );
                context.read<CartBloc>().add(AddToCartEvent(cartItem));
              },
              child: const Text('Add to Cart'),
            ),
            // Display cart loading/error messages
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CartError) {
                  return Text('Error: ${state.error}');
                } else if (state is CartLoaded) {
                  return const Text('Added to cart!');
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
