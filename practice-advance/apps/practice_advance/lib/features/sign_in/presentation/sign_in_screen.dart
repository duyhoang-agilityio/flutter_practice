// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/sign_in/data/sign_in_box_impl.dart';
import 'package:practice_advance/features/sign_in/domain/usecases/sign_in_usecase.dart';
import 'package:practice_advance/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance/router.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: BlocProvider(
        create: (context) => LoginBloc(
          usecases: locator<SignInUsecase>(),
          isarService: locator<SignInBox>(),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // Navigate to the next screen on success
              context.pushNamed(AppRouteNames.home.name);
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator();
                    }

                    return ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(
                              LoginRequested(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                      },
                      child: const Text("Login"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
