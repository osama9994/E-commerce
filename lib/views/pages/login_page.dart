import 'package:animation_project/utils/app_color.dart';
import 'package:animation_project/views/widgets/label_with_textfield.dart';
import 'package:animation_project/views/widgets/main_botton.dart';
import 'package:animation_project/views/widgets/social_media_botton.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text("Login Account", style: TextTheme.of(context).titleLarge),
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
                  suffixIcon: IconButton(icon:const Icon( Icons.visibility), onPressed: () {}),
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
                MainBotton(text: "Lgoin", onTap: () {
                  if(_formKey.currentState!.validate()){
                    
                  }
                }),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {},
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
                      SocialMediaBotton(
                        text: "Login with Google",
                        icon: Icons.g_mobiledata,
                        ontap: () {},
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
    );
  }
}
