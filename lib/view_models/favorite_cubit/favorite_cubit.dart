import 'package:animation_project/models/product_item_model.dart';
import 'package:animation_project/services/auth_sevrices.dart';
import 'package:animation_project/services/favorite_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final FavoriteServices favoriteServices = FavoriteServicesImpl();
  final AuthServices authServices = AuthServicesImpl();
  Future<void> getFavoriteProducts() async {
    emit(FavoriteLoading());
    try {
      final currentUser = authServices.currentUser();
      if (currentUser == null) {
        emit(FavoriteError("User not logged in"));
        return;
      }
      final favoriteProducts = await favoriteServices.getFavorites(
        currentUser.uid
        );
      emit(FavoriteLoaded(favoriteProducts));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
  Future<void>removeFavoriteProduct(String productId) async {
  emit(FavoriteRemoving(productId));
  try {
    final currentUser = authServices.currentUser();
     if (currentUser == null) {
      emit(FavoriteRemoveError("User not logged in"));
      return;
    }
    await favoriteServices.removeFavorite(
      currentUser.uid,
      productId,
    );
    emit(FavoriteRemoved(productId));
 final favoriteProducts = await favoriteServices.getFavorites(
        currentUser.uid
        );
        emit(FavoriteLoaded(favoriteProducts));
  } catch (e) {
    emit(FavoriteRemoveError(e.toString()));
  }
}
}