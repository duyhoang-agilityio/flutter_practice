import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/text.dart';

class ListVendor extends StatelessWidget {
  const ListVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorBloc, VendorState>(
      listener: (_, state) {},
      builder: (_, state) {
        if (state is VendorInitial) {
          return const BazarCircularProgressIndicator();
        } else if (state is VendorLoaded) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.vendors?.length,
              itemBuilder: (BuildContext context, int index) {
                final item = state.vendors?[index];

                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: BazarBodyLargeText(text: item?.name ?? ''),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
