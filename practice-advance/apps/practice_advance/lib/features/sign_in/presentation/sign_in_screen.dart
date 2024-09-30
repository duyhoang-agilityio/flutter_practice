// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/sign_in/data/sign_in_box_impl.dart';
import 'package:practice_advance/features/sign_in/domain/usecases/sign_in_usecase.dart';
import 'package:practice_advance/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/buttons/elevated_button.dart';
import 'package:practice_advance_design/widgets/buttons/outlined_button.dart';
import 'package:practice_advance_design/widgets/buttons/text_button.dart';
import 'package:practice_advance_design/widgets/divider.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/widgets/text.dart';
import 'package:practice_advance_design/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return BazarScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: BazarIcon.icArrowBack(),
          onPressed: () {
            // Handle back press
          },
        ),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(
          usecases: locator<SignInUsecase>(),
          isarService: locator<SignInBox>(),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (_, state) {
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BazarHeadlineLargeTitle(text: localizations.txtWelcomeBack),
                  const SizedBox(height: 8),
                  BazarBodyLargeText(text: localizations.txtSignInYourAccount),
                  const SizedBox(height: 32),
                  BazarTextField(
                    text: localizations.txtEmail,
                    hintText: localizations.txtYourEmail,
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 16),
                  BazarTextField(
                    text: localizations.txtPassword,
                    hintText: localizations.txtYourPassword,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BazarTextButton(
                      onPressed: () {
                        // Handle forgot password
                      },
                      text: localizations.txtForgotPassword,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const CircularProgressIndicator();
                      }

                      return BazarElevatedButton(
                        onPressed: () => context.read<LoginBloc>().add(
                              LoginRequested(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            ),
                        text: localizations.txtLogin,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BazarBodyMediumText(
                        text: localizations.txtDontHaveAccount,
                      ),
                      BazarTextButton(
                        onPressed: () {
                          // Handle sign up
                        },
                        text: localizations.txtSignUp,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(child: BazarDivider()),
                      const SizedBox(width: 10),
                      BazarBodyMediumText(text: localizations.txtOrWith),
                      const SizedBox(width: 10),
                      const Expanded(child: BazarDivider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  BazarOutLinedIconButton(
                    width: double.infinity,
                    onPressed: () {
                      // Handle Google sign-in
                    },
                    icon: BazarIcon.icAdd(),
                    text: localizations.txtSigninWithGoogle,
                  ),
                  const SizedBox(height: 15),
                  BazarOutLinedIconButton(
                    width: double.infinity,
                    onPressed: () {
                      // Handle Google sign-in
                    },
                    icon: BazarIcon.icAdd(),
                    text: localizations.txtSigninWithApple,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
