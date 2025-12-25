import 'package:animation_project/services/auth_sevrice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthServices authServices=AuthServicesImpl();
  Future<void> loginWithEmailAndPassowrd(String email, String password) async {
    emit(AuthLoading());
    try {
    final result= await authServices.loginWithEmailAndPassowrd(email, password);
      if(result){
        emit(AuthDone());
      }else{
        emit(AuthError("Login Failed"));
      }
      
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  Future<void> registerWithEmailAndPassowrd(String email, String password) async {
    emit(AuthLoading());
    try {
    final result= await authServices.registerWithEmailAndPassowrd(email, password);
      if(result){
        emit(AuthDone());
      }else{
        emit(AuthError("Registration Failed"));
      }
      
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  void checkAuth(){
    final user=authServices.curretnUser();
    if(user !=null){
      emit(const AuthDone());
    }
  }

Future<void> logout() async {
    emit(AuthLogingOut());
    try {
      await authServices.logout();
      emit(const AuthLoggedOut());
    } catch (e) {
      emit(AuthLogOutError(e.toString()));
    }
  }

}
