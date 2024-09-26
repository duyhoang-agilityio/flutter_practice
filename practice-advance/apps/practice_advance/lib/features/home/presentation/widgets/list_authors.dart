import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';
import 'package:practice_advance_design/widgets/text.dart';

class ListAuthors extends StatelessWidget {
  const ListAuthors({super.key});

  @override
  Widget build(BuildContext context) => Column(
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
                              CircleAvatar(
                                radius: 50,
                                child: BazarImage.imgOnboarding1(),
                              ),
                              const SizedBox(height: 8),
                              BazarBodyMediumText(
                                text: item?.name ?? '',
                                maxLines: 1,
                              ),
                              const SizedBox(height: 8),
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
              return const SizedBox.shrink();
            },
          ),
        ],
      );
}
