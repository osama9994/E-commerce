import 'package:animation_project/utils/app_routes.dart';
import 'package:animation_project/view_models/auth_cubit/auth_cubit.dart';
import 'package:animation_project/views/widgets/main_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit=BlocProvider.of<AuthCubit>(context);
    return  
     Padding(
       padding: const EdgeInsets.symmetric(horizontal:16),
       child: Center(
          child: BlocConsumer<AuthCubit, AuthState>(
            bloc: cubit,
            listenWhen: (previous, current) =>  current is AuthLoggedOut || current is AuthLogOutError,
            listener: (context, state) {
             if(state is AuthLoggedOut){
               Navigator.of(context,rootNavigator: true).pushNamedAndRemoveUntil(AppRoutes.loginRoute,(route)=>false);
              }
              else if(state is AuthLogOutError){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            buildWhen: (previous, current) => current is AuthLogingOut,
            builder: (context, state) {
              if(state is AuthLogingOut ){
                return MainBotton(isLoading:true,
              
                );
              }
              return MainBotton(
                    text: "Logout",
                    onTap:()async => await cubit.logout(),
                  );
            },
          ),
        
           ),
     );
  }
}