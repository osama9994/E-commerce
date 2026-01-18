import 'package:animation_project/models/home_carousel_item_model.dart';
import 'package:animation_project/models/product_item_model.dart';
import 'package:animation_project/services/auth_sevrices.dart';
import 'package:animation_project/services/favorite_services.dart';
import 'package:animation_project/services/home_servieces.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomeServices homeServices = HomeServicesImpl();
  final authServices=AuthServicesImpl();
  final favoriteServices=FavoriteServicesImpl();
  
  // Keep track of the last HomeLoaded state for operations
  HomeLoaded? _lastHomeLoadedState;

  Future<void> getHomeData() async { 
    emit(HomeLoading());

    try {
      final currentUser=authServices.currentUser();
      final List<ProductItemModel> products =await homeServices.fetchProducts();
      final List<HomeCarouselItemModel>  carouselItems = await homeServices.fetchHomeCarouselItems();
      final favoriteProducts = await favoriteServices.getFavorites(currentUser!.uid);
     
      debugPrint('Fetched ${products.length} products');
      for (var product in products) {
        debugPrint('Product: ${product.name}, Image URL: ${product.imgUrl}');
      }

      final List<ProductItemModel> finalProducts = products.map((products) {
        final isFavorite=favoriteProducts.any((item) => item.id==products.id);
        return products.copyWith(isFavorite: isFavorite);
      }).toList();

      final homeLoaded = HomeLoaded(
        carouselItems: carouselItems,
        product: finalProducts,
      );
      _lastHomeLoadedState = homeLoaded;
      emit(homeLoaded);
    } catch (e) {
      debugPrint('Error fetching home data: $e');
      emit(HomeError(e.toString()));
    }
  }

   Future<void> setFavorite(ProductItemModel product) async {
    final currentState = state;
    // Get the HomeLoaded state - either from current state or from our stored reference
    HomeLoaded homeLoadedState;
    if (currentState is HomeLoaded) {
      homeLoadedState = currentState;
      _lastHomeLoadedState = currentState;
    } else if (_lastHomeLoadedState != null) {
      // Use stored state if current state is SetFavoriteSuccess/SetFavoriteLoading/SetFavoriteFailed
      homeLoadedState = _lastHomeLoadedState!;
    } else {
      // Can't proceed without HomeLoaded state
      return;
    }

    emit(SetFavoriteLoading(product.id));
    try {
      final currentUser = authServices.currentUser();

      // Always read the latest favorite state from the HomeLoaded products list
      final currentProduct = homeLoadedState.product.firstWhere(
        (item) => item.id == product.id,
        orElse: () => product,
      );
      final isFavorite = currentProduct.isFavorite;

      if (isFavorite) {
        await favoriteServices.removeFavorite(currentUser!.uid, product.id);
      } else {
        await favoriteServices.addFavorite(currentUser!.uid, product);
      }

      final updatedProducts = homeLoadedState.product
          .map((item) => item.id == product.id
              ? item.copyWith(isFavorite: !isFavorite)
              : item)
          .toList();

      final updatedHomeLoaded = HomeLoaded(
        carouselItems: homeLoadedState.carouselItems,
        product: updatedProducts,
      );
      _lastHomeLoadedState = updatedHomeLoaded;
      
      // Emit HomeLoaded first, then SetFavoriteSuccess for UI feedback
      // This ensures the state can be used for subsequent operations
      emit(updatedHomeLoaded);
      emit(SetFavoriteSuccess(isFavorite: !isFavorite, productId: product.id));
    } catch (e) {
      emit(SetFavoriteFailed(e.toString(), product.id));
    }
  }

}
