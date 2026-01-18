import 'package:animation_project/utils/app_router.dart';
import 'package:animation_project/utils/app_routes.dart';
import 'package:animation_project/view_models/auth_cubit/auth_cubit.dart';
import 'package:animation_project/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       BlocProvider<AuthCubit>(
        create:(context){
          final cubit=AuthCubit();
          cubit.checkAuth();
          return cubit;
        } ,
         ),
           BlocProvider<FavoriteCubit>(
        create:(context){
          final cubit=FavoriteCubit();
          // Don't load favorites immediately - let the page handle it when user is logged in
          // This prevents errors when user is not logged in yet
          return cubit;
        } ,
        ),
      ],
     
      
      child: Builder(
        builder: (context) {
          final authCubit = context.read<AuthCubit>();

          return BlocBuilder<AuthCubit, AuthState>(
            bloc: authCubit,
            buildWhen: (previous, current) =>
                current is AuthDone || current is AuthInitial,
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "E-commerce App",
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.deepPurple,
                  ),
                  useMaterial3: true,
                ),
                initialRoute: state is AuthDone
                    ? AppRoutes.homeRoute
                    : AppRoutes.loginRoute,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
