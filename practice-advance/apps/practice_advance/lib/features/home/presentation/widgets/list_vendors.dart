import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';
import 'package:practice_advance_design/widgets/empty.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/indicators/skeletonize_loading.dart';

class ListVendor extends StatelessWidget {
  const ListVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorBloc, VendorState>(
      buildWhen: (_, current) =>
          current is VendorLoaded || current is VendorInitial,
      builder: (_, state) {
        if (state is VendorInitial) {
          return const BazarSkeletonize(enabled: true, child: ListVendors());
        } else if (state is VendorLoaded) {
          return (state.vendors?.isEmpty ?? true)
              ? const EmptyData(
                  message: 'No Vendors available',
                )
              : ListVendors(vendors: state.vendors);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ListVendors extends StatelessWidget {
  const ListVendors({
    super.key,
    this.vendors,
  });

  final List<Vendor>? vendors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: vendors?.length ?? 4,
        itemBuilder: (BuildContext context, int index) {
          final item = vendors?[index] ?? Vendor(vendorId: 1);

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: BazarCachedNetworkImage(
              height: 80,
              radius: BorderRadius.circular(10),
              imagePath: item.image ?? '',
            ),
          );
        },
      ),
    );
  }
}
