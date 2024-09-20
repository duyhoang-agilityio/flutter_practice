import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';

class ListAuthorsScreen extends StatelessWidget {
  const ListAuthorsScreen({super.key, required this.bloc});

  final AuthorBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BazarScaffold(
      body: BlocProvider<AuthorBloc>.value(
        value: bloc..add(GetListAuthorsEvent()),
        child: const SafeArea(
          child: Column(
            children: [
              // Author title

              // List categories

              // List all Author by category
            ],
          ),
        ),
      ),
    );
  }
}
