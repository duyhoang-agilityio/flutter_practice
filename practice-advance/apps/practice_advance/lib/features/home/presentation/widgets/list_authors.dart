import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';
import 'package:practice_advance_design/widgets/text.dart';

class ListAuthors extends StatelessWidget {
  const ListAuthors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<AuthorBloc, AuthorState>(
          listener: (_, state) {
            if (state is AuthorError) {
              BazarSnackBarContentError(
                context,
                message: state.message,
              );
            }
          },
          builder: (_, state) {
            if (state is AuthorInitial) {
              return const BazarCircularProgressIndicator();
            } else if (state is AuthorLoaded) {
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.authors?.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = state.authors?[index];

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
        ),
      ],
    );
  }
}
