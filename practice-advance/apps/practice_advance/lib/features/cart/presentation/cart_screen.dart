import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/core/extensions/double_extension.dart';
import 'package:practice_advance/features/cart/data/cart_box_impl.dart';
import 'package:practice_advance/features/cart/domain/usecases/cart_usecase.dart';
import 'package:practice_advance/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/molecules/list_tile.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/app_bar.dart';
import 'package:practice_advance_design/widgets/buttons/elevated_button.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/circle_avatar.dart';
import 'package:practice_advance_design/widgets/empty.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';
import 'package:practice_advance_design/widgets/text.dart';

/// Screen displaying the cart and allowing users to manage their cart items.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return BlocProvider<CartBloc>(
      create: (_) => CartBloc(locator<CartUsecase>(), locator<CartDataSource>())
        ..add(LoadCartItemsEvent()), // Load cart items when the screen is built
      child: BazarScaffold(
        appBar: BazarAppBar(
          title: BazarHeadlineLargeTitle(text: localizations.txtMyCart),
          trailing: BazarIconButtons(
            icon: BazarIcon.icNotification(),
            onPressed: () {
              // FIXED: Implement notification function
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
          buildWhen: (previous, current) =>
              current is CartItemsLoadedState ||
              current is CartItemsLoadingState ||
              current is CartEmptyState,
          builder: (context, state) {
            if (state is CartItemsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartEmptyState) {
              return BazarEmptyData(message: localizations.txtNoProductInCart);
            } else if (state is CartItemsLoadedState) {
              return _CartItems(cartItems: state.items);
            }

            // Return an empty widget if no relevant state is found
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _CartItems extends StatelessWidget {
  const _CartItems({required this.cartItems});

  final List<Vendor> cartItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: cartItems.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (_, index) {
                final item = cartItems[index];

                return _CartItem(item: item);
              },
            ),
          ),
          const SizedBox(height: 10),
          BazarElevatedButton(
            text: AppLocalizations.of(context)!.txtCheckout,
            onPressed: () => context.read<CartBloc>().add(
                  CheckoutCartEvent(
                    vendors: cartItems,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({required this.item});

  final Vendor item;

  @override
  Widget build(BuildContext context) {
    return BazarListTile(
      contentPadding: EdgeInsets.zero,
      leading: BazarCircleAvatar(
        child: BazarCachedNetworkImage(
          imagePath: item.image ?? '',
          radius: BorderRadius.circular(10),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BazarBodyMediumText(text: item.name ?? ''),
          ),
          BazarBodyMediumText(text: '${item.quantity ?? 1}'),
        ],
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            Expanded(
              child: BazarBodyMediumText(
                text: (item.price ?? 0).toCurrency(),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              child: BazarIcon.icDelete(color: context.colorScheme.primary),
              onTap: () => context.read<CartBloc>().add(
                    RemoveVendorFromCartEvent(
                      vendorId: item.vendorId,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
