import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';
import 'package:practice_advance_design/tokens/sizes.dart';
import 'package:practice_advance_design/widgets/empty.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/indicators/skeletonize_loading.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';

/// A stateless widget that displays a list of vendors.
class ListVendor extends StatelessWidget {
  const ListVendor({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<VendorBloc, VendorState>(
        /// Listens for state changes in the VendorBloc.
        listener: (_, state) {
          if (state is VendorError) {
            // Show error message if there's an error in the vendor state.
            BazarSnackBarContentError(
              context,
              message: state.message,
            );
          }
        },

        /// Determines when to rebuild the widget based on state changes.
        buildWhen: (_, current) =>
            current is VendorLoaded || current is VendorInitial,
        builder: (_, state) {
          // Show a skeleton loader while the state is initial.
          if (state is VendorInitial) {
            return const BazarSkeletonize(enabled: true, child: ListVendors());
          }
          // Display the loaded vendors or an empty state if no vendors are found.
          else if (state is VendorLoaded) {
            return (state.vendors?.isEmpty ?? true)
                ? EmptyData(
                    message:
                        AppLocalizations.of(context)!.txtNoVendorsAvailable,
                  )
                : ListVendors(vendors: state.vendors); // Show vendor items.
          }
          // Return an empty widget if no relevant state matches.
          return const SizedBox.shrink();
        },
      );
}

/// A stateless widget that displays a horizontal list of vendor images.
class ListVendors extends StatelessWidget {
  const ListVendors({
    super.key,
    this.vendors,
  });

  final List<Vendor>? vendors;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: BazarSizingTokens.vendorItemHeight,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          // Fallback to 4 if vendors are null.
          itemCount: vendors?.length ?? 4,
          itemBuilder: (BuildContext context, int index) {
            // Get the vendor item or create a placeholder vendor.
            final item = vendors?[index] ?? Vendor(vendorId: 1);

            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: BazarCachedNetworkImage(
                height: BazarSizingTokens.vendorItemHeight,
                radius: BorderRadius.circular(10),
                imagePath: item.image ?? '',
              ),
            );
          },
        ),
      );
}
