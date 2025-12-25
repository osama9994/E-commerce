
import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/utils/app_routes.dart';
import 'package:animation_project/view_models/auth_cubit/auth_cubit.dart';
import 'package:animation_project/views/widgets/label_with_textfield.dart';
import 'package:animation_project/views/widgets/main_botton.dart';
import 'package:animation_project/views/widgets/social_media_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
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
                    "Create Account",
                    style: TextTheme.of(context).titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Start shopping with create your account",
                    style: TextTheme.of(
                      context,
                    ).labelLarge!.copyWith(color: AppColor.grey),
                  ),
                  const SizedBox(height: 8),
                  LabelWithTextfield(
                    label: "Username",
                    prefixIcon: Icons.person,
                    hintText: "Enter your username",
                    controller: usernameController,
                  ),
                  const SizedBox(height: 8),
                  LabelWithTextfield(
                    label: "Email",
                    prefixIcon: Icons.person,
                    hintText: "Enter your Email",
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

                  const SizedBox(height: 40),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: cubit,
                    listenWhen: (previous, current) => current is AuthDone||current is AuthError,
                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.pushNamed(context, AppRoutes.homeRoute);
                      }else if(state is AuthError){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
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
                        text: "Create Account",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.registerWithEmailAndPassowrd(
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
                            Navigator.pop(context);
                          },
                          child: Text(
                            "You have an account? Login",
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
                        SocialMediaBotton(
                          text: "Sign up with Google",
                          icon: Icons.g_mobiledata,
                          ontap: () {},
                        ),
                        const SizedBox(height: 16),
                        SocialMediaBotton(
                          text: "Sign up with Facebook",
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
