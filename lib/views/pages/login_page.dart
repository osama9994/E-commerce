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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
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
                  Text(
                    "Login Account",
                    style: TextTheme.of(context).titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please Login with registered account",
                    style: TextTheme.of(
                      context,
                    ).labelLarge!.copyWith(color: AppColor.grey),
                  ),
                  const SizedBox(height: 8),
                  LabelWithTextfield(
                    label: "Email",
                    prefixIcon: Icons.email,
                    hintText: "Enter your email",
                    controller: emailController,
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextfield(
                    label: "Password",
                    prefixIcon: Icons.password,
                    hintText: "Enter your password",
                    obscureText: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {},
                    ),
                    controller: passwordController,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextTheme.of(
                          context,
                        ).labelLarge!.copyWith(color: AppColor.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: cubit,
                    listenWhen:
                        (previous, current) =>
                            current is AuthDone || current is AuthError,

                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.pushNamed(context, AppRoutes.homeRoute);
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    buildWhen:
                        (previous, current) =>
                            current is AuthLoading ||
                            current is AuthError ||
                            current is AuthDone,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return MainBotton(isLoading: true);
                      }
                      return MainBotton(
                        text: "Lgoin",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.loginWithEmailAndPassowrd(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
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
                            style: TextTheme.of(
                              context,
                            ).labelLarge!.copyWith(color: AppColor.primary),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Or using other methods",
                          textAlign: TextAlign.center,
                          style: TextTheme.of(
                            context,
                          ).labelLarge!.copyWith(color: AppColor.grey),
                        ),
                        const SizedBox(height: 16),
                        BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,
                          listenWhen: (previous, current) => current is GoogleAuthDone || current is GoogleAuthError,
                          listener: (context, state) {
                           if(state is GoogleAuthDone){
                            Navigator.pushNamed(context, AppRoutes.homeRoute);
                           } else if(state is GoogleAuthError){
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(state.message)));
                           }
                          },
                          buildWhen: (previous, current) => current is GoogleAuthenticating || current is GoogleAuthError || current is GoogleAuthDone,
                          builder: (context, state) {
                            if(state is GoogleAuthenticating){
                              return SocialMediaBotton(
                                isLoading: true,
                                text: "Login with Google",
                                icon: Icons.g_mobiledata,
                                ontap: () {},
                              );
                            }
                            return SocialMediaBotton(
                              text: "Login with Google",
                              icon: Icons.g_mobiledata,
                              ontap:
                                  () async =>
                                      await cubit.authenticateWithGoogle(),
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
