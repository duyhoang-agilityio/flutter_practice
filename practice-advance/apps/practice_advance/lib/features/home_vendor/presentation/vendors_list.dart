import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';

class ListAuthorsScreen extends StatelessWidget {
  const ListAuthorsScreen({super.key, required this.bloc});

  final VendorBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BazarScaffold(
      body: BlocProvider<VendorBloc>.value(
        value: bloc..add(GetListVendorsEvent()),
        child: const SafeArea(
          child: Column(
            children: [
              // Vendor title

              // List categories

              // List all Vendors by category
            ],
          ),
        ),
      ),
    );
  }
}
