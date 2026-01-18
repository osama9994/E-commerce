part of 'home_cubit.dart';


sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeLoaded extends HomeState {

HomeLoaded({
 required this.carouselItems,
 required this.product,
});
final List<HomeCarouselItemModel>carouselItems;
final List<ProductItemModel>product;
}

final class HomeError extends HomeState {
HomeError(
 this.message
);
final String message;

}

final class SetFavoriteLoading extends HomeState {
  final String productId;
  SetFavoriteLoading( this.productId);
}
final class SetFavoriteSuccess extends HomeState {
  final bool isFavorite;
final String productId; 
  SetFavoriteSuccess({required this.isFavorite, required this.productId});
}
final class SetFavoriteFailed extends HomeState {
SetFavoriteFailed(
 this.message, this.productId
);
final String message;
final String productId;
}