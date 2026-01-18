import 'package:animation_project/models/add_to_cart_model.dart';
import 'package:animation_project/models/product_item_model.dart';
import 'package:animation_project/services/auth_sevrices.dart';
import 'package:animation_project/services/product_details_services.dart';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  
   ProductSize? selectedsize;
   int quantity=1;
   final productDetailsServices=ProductDetailsServicesImpl();
   final authServices=AuthServicesImpl();

  void getProductDetails(String id)async {
    emit(ProductDetailsLoading());
    try{
      final selectedProduct= await productDetailsServices.fetchProductDetails(id);
     emit(ProductDetailsLoaded(product: selectedProduct));
    }
    catch(e){
      emit(ProductDetailsError( e.toString()));
    }
    // Future.delayed(Duration(seconds: 1), () {
    //   final selectedProduct = dummyProducts.firstWhere((item) => item.id == id);
    //   emit(ProductDetailsLoaded(product: selectedProduct));
    // });
  }


void selectedSize(ProductSize size){
  selectedsize =size;
emit(SizeSelected(size: size));
}  

Future<void> addToCart(String productId,)async{
  emit(ProductAddingToCart());
  try{
          final selectedProduct= await productDetailsServices.fetchProductDetails(productId);
 final currentUser=authServices.currentUser();
 final  cartItem=AddToCartModel(
    id:DateTime.now().toIso8601String(),
    product: selectedProduct,
    size: selectedsize!,
    quantity: quantity
  );
  await productDetailsServices.addToCart(cartItem, currentUser!.uid);
  emit(ProductAddedToCart(productId: productId));
  }
  catch(e){
    emit(PorductAddToCartError(e.toString()));
  }
 

 
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
