import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';
import 'package:practice_advance_design/widgets/text.dart';

/// A stateless widget that displays a list of authors.
class ListAuthors extends StatelessWidget {
  const ListAuthors({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          BlocConsumer<AuthorBloc, AuthorState>(
            /// Listens for changes in the AuthorBloc state.
            listener: (_, state) {
              if (state is AuthorError) {
                // Show error message in case of an error state.
                BazarSnackBarContentError(
                  context,
                  message: state.message,
                );
              }
            },
            builder: (_, state) {
              // Show loading indicator while the state is initial.
              if (state is AuthorInitial) {
                return const BazarCircularProgressIndicator();
              }
              // Display authors when the state is loaded.
              else if (state is AuthorLoaded) {
                return SizedBox(
                  height: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.authors?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = state.authors?[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SizedBox(
                          width: 127,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display author's image
                              CircleAvatar(
                                radius: 50,
                                child: BazarImage.imgOnboarding1(),
                              ),
                              const SizedBox(height: 8),
                              // Display author's name
                              BazarBodyMediumText(
                                text: item?.name ?? '',
                                maxLines: 1,
                              ),
                              const SizedBox(height: 8),
                              // Display author's description
                              BazarBodySmallText(
                                text: item?.desc ?? '',
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              // Return an empty widget if no state matches.
              return const SizedBox.shrink();
            },
          ),
        ],
      );
}
