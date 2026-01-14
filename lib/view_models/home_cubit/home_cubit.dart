import 'package:animation_project/models/home_carousel_item_model.dart';
import 'package:animation_project/models/product_item_model.dart';
import 'package:animation_project/services/auth_sevrices.dart';
import 'package:animation_project/services/home_servieces.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomeServices homeServices = HomeServicesImpl();
  final authServices=AuthServicesImpl();

  Future<void> getHomeData() async {
    emit(HomeLoading());

    try {
      final currentUser=authServices.curretnUser();
      final List<ProductItemModel> products =await homeServices.fetchProducts();
      final List<HomeCarouselItemModel>  carouselItems = await homeServices.fetchHomeCarouselItems();
      final favoriteProducts = await homeServices.fetchFavoriteProducts(currentUser!.uid);

      final List<ProductItemModel> finalProducts = products.map((products) {
        final isFavorite=favoriteProducts.any((item) => item.id==products.id);
        return products.copyWith(isFavorite: isFavorite);
      }).toList();

      emit(
        HomeLoaded(
          carouselItems: carouselItems,
          product: finalProducts,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

   Future<void> setFavorite(ProductItemModel product) async {
    final currentState = state;
    if (currentState is! HomeLoaded) return;

    emit(SetFavoriteLoading(product.id));
    try {
      final currentUser = authServices.curretnUser();
      final isFavorite = product.isFavorite;

      if (isFavorite) {
        await homeServices.removeFavoriteProduct(
            userId: currentUser!.uid, productId: product.id);
      } else {
        await homeServices.addFavoriteProduct(
            userId: currentUser!.uid, product: product);
      }

      final updatedProducts = currentState.product
          .map((item) => item.id == product.id
              ? item.copyWith(isFavorite: !isFavorite)
              : item)
          .toList();

      emit(
        HomeLoaded(
          carouselItems: currentState.carouselItems,
          product: updatedProducts,
        ),
      );
      emit(SetFavoriteSuccess(isFavorite: !isFavorite, productId: product.id));
    } catch (e) {
      emit(SetFavoriteFailed(e.toString(), product.id));
    }
  }

}
