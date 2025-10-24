import 'package:animation_project/models/add_to_cart_model.dart';
import 'package:animation_project/models/product_item_model.dart';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  
   ProductSize? selectedsize;
   int quantity=1;

  void getProductDetails(String id) {
    emit(ProductDetailsLoading());
    Future.delayed(Duration(seconds: 1), () {
      final selectedProduct = dummyProducts.firstWhere((item) => item.id == id);
      emit(ProductDetailsLoaded(product: selectedProduct));
    });
  }


void selectedSize(ProductSize size){
  selectedsize =size;
emit(SizeSelected(size: size));
}  

void addToCart(String productId,){
  emit(ProductAddingToCart());
  final  cartItem=AddToCartModel(
    id:DateTime.now().toIso8601String(),
    product: dummyProducts.firstWhere((item) => item.id == productId),
    size: selectedsize!,
    quantity: quantity
  );
  dummyCart.add(cartItem);
  Future.delayed(const Duration(seconds: 1),(){
    emit(ProductAddedToCart(productId: productId));
  });
}


void incrementCounter(String productID){
quantity++;
emit(QuantityCounterLoaded(
  value:quantity
  )
  ); 
}


void decrementCounter(String productID){
  
  quantity--;
emit(QuantityCounterLoaded(
  value:quantity
  ) 
  ); 
}




}
