import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/utils/app_routes.dart';
import 'package:animation_project/view_models/auth_cubit/auth_cubit.dart';
import 'package:animation_project/views/widgets/label_with_textfield.dart';
import 'package:animation_project/views/widgets/main_botton.dart';
import 'package:animation_project/views/widgets/social_media_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit cubit = context.read<AuthCubit>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),

                  /// Title
                  Text(
                    "Login Account",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "Please login with your registered account",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColor.grey),
                  ),
                  const SizedBox(height: 24),

                  /// Email
                  LabelWithTextfield(
                    label: "Email",
                    prefixIcon: Icons.email,
                    hintText: "Enter your email",
                    controller: emailController,
                  ),
                  const SizedBox(height: 24),

                  /// Password
                  LabelWithTextfield(
                    label: "Password",
                    prefixIcon: Icons.lock,
                    hintText: "Enter your password",
                    obscureText: true,
                    controller: passwordController,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColor.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// LOGIN BUTTON
                  BlocConsumer<AuthCubit, AuthState>(
                    listenWhen: (p, c) =>
                        c is AuthDone || c is AuthError,
                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.homeRoute,
                          (route) => false,
                        );
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    buildWhen: (p, c) =>
                        c is AuthLoading ||
                        c is AuthDone ||
                        c is AuthError,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return  MainBotton(isLoading: true);
                      }

                      return MainBotton(
                        text: "Login",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.loginWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                          }
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  /// Go to Register
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.registerRoute,
                            );
                          },
                          child: Text(
                            "Don't have an account? Register",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: AppColor.primary),
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          "Or using other methods",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColor.grey),
                        ),
                        const SizedBox(height: 16),

                        /// GOOGLE LOGIN
                        BlocConsumer<AuthCubit, AuthState>(
                          listenWhen: (p, c) =>
                              c is GoogleAuthDone ||
                              c is GoogleAuthError,
                          listener: (context, state) {
                            if (state is GoogleAuthDone) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.homeRoute,
                                (route) => false,
                              );
                            } else if (state is GoogleAuthError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                ),
                              );
                            }
                          },
                          buildWhen: (p, c) =>
                              c is GoogleAuthenticating ||
                              c is GoogleAuthDone ||
                              c is GoogleAuthError,
                          builder: (context, state) {
                            if (state is GoogleAuthenticating) {
                              return  SocialMediaBotton(
                                isLoading: true,
                                text: "Login with Google",
                                icon: Icons.g_mobiledata,
                                ontap: null,
                              );
                            }

                            return SocialMediaBotton(
                              text: "Login with Google",
                              icon: Icons.g_mobiledata,
                              ontap: () async {
                                await cubit.signInWithGoogle();
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        SocialMediaBotton(
                          text: "Login with Facebook",
                          icon: Icons.facebook,
                          ontap: () {},
                        ),
                      ],
                    ),
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
