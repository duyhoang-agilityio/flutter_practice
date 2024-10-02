// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/sign_in/data/sign_in_box_impl.dart';
import 'package:practice_advance/features/sign_in/domain/usecases/sign_in_usecase.dart';
import 'package:practice_advance/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/core/extensions/context_extension.dart';
import 'package:practice_advance_design/widgets/buttons/elevated_button.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/buttons/outlined_button.dart';
import 'package:practice_advance_design/widgets/buttons/text_button.dart';
import 'package:practice_advance_design/widgets/images/icon.dart';
import 'package:practice_advance_design/widgets/layout/divider.dart';
import 'package:practice_advance_design/widgets/layout/scaffold.dart';
import 'package:practice_advance_design/widgets/text/text.dart';
import 'package:practice_advance_design/widgets/text_field/text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    bool showPassword = true;

    return BazarScaffold(
      body: SafeArea(
        child: BlocProvider(
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
                  SnackBar(
                    content: BazarHeadlineLargeTitle(
                      text: state.error,
                      color: context.colorScheme.surface,
                    ),
                    backgroundColor: context.colorScheme.primary,
                  ),
                );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is ShowPasswordSuccess) {
                  showPassword = state.showPassword;
                }

                return Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BazarHeadlineLargeTitle(
                            text: localizations.txtWelcomeBack),
                        const SizedBox(height: 8),
                        BazarBodyLargeText(
                          text: localizations.txtSignInYourAccount,
                        ),
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
                          obscureText: showPassword,
                          suffixIcon: BazarIconButtons(
                            icon: Icon(Icons.remove_red_eye,
                                color: context.colorScheme.tertiary),
                            onPressed: () => context.read<LoginBloc>().add(
                                  ShowPasswordEvent(showPassword: showPassword),
                                ),
                          ),
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
                          builder: (context, state) => BazarElevatedButton(
                            isLoading: state is LoginLoading,
                            onPressed: () => context.read<LoginBloc>().add(
                                  LoginRequested(
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                  ),
                                ),
                            text: localizations.txtLogin,
                            textColor: context.colorScheme.surface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BazarBodyLargeText(
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
                            BazarBodyLargeText(text: localizations.txtOrWith),
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
                          icon: BazarIcon.icGoogle(),
                          text: localizations.txtSigninWithGoogle,
                        ),
                        const SizedBox(height: 15),
                        BazarOutLinedIconButton(
                          width: double.infinity,
                          onPressed: () {
                            // Handle Apple sign-in
                          },
                          icon: BazarIcon.icApple(),
                          text: localizations.txtSigninWithApple,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
