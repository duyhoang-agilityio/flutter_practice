import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/core/extensions/double_extension.dart';
import 'package:practice_advance/features/cart/data/cart_box_impl.dart';
import 'package:practice_advance/features/cart/domain/usecases/cart_usecase.dart';
import 'package:practice_advance/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/molecules/list_tile.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/app_bar.dart';
import 'package:practice_advance_design/widgets/buttons/elevated_button.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';
import 'package:practice_advance_design/widgets/text.dart';

/// Screen displaying the cart and allowing users to manage their cart items.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (_) => CartBloc(locator<CartUsecase>(), locator<CartDataSource>())
        ..add(LoadCartItemsEvent()), // Load cart items when the screen is built
      child: BazarScaffold(
        appBar: BazarAppBar(
          title: const Text('My Cart'), // AppBar title
          trailing: BazarIconButtons(
            icon: BazarIcon.icNotification(),
            onPressed: () {
              // TODO: Implement notification function
            },
          ),
        ),
        body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            // Listening for state changes
            if (state is CartErrorState) {
              BazarSnackBarContentError(context, message: state.error);
            } else if (state is CartCheckoutSuccessState) {
              // Navigate to cart if checkout is successful
              context.pushNamed(AppRouteNames.cart.name);
            }
          },
          builder: (context, state) {
            if (state is CartItemsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartEmptyState) {
              return const Center(
                child: BazarBodyMediumText(
                  text: 'There are no products in your cart',
                ),
              );
            } else if (state is CartItemsLoadedState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BazarHeadlineLargeTitle(text: 'Products'),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: state.items.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (_, index) {
                          final item = state.items[index];

                          return BazarListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              minRadius: 30,
                              maxRadius: 30,
                              child: BazarCachedNetworkImage(
                                imagePath: item.thumbnail ?? '',
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BazarBodyMediumText(
                                  text: item.title ?? '',
                                ),
                                BazarBodyMediumText(
                                  text: '${item.quantity ?? 1}',
                                ),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: BazarBodyMediumText(
                                      text: (item.price ?? 0.0).toCurrency(),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.amber,
                                    ),
                                    onTap: () => context.read<CartBloc>().add(
                                          RemoveProductFromCartEvent(
                                            productId: item.productId,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    BazarElevatedButton(
                      text: 'Checkout',
                      onPressed: () => context.read<CartBloc>().add(
                            CheckoutCartEvent(
                              products: state.items,
                            ),
                          ),
                    ),
                  ],
                ),
              );
            }

            // Return an empty widget if no relevant state is found
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
