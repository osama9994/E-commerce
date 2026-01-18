import 'package:animation_project/models/add_to_cart_model.dart';
import 'package:animation_project/models/product_item_model.dart';
import 'package:animation_project/services/firestore_services.dart';
import 'package:animation_project/utils/api_pathes.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> fetchProductDetails(String productId);
  Future<void> addToCart(AddToCartModel cartItem, String userId);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final FirestoreServices firestoreServices = FirestoreServices.instance;
  @override
  Future<ProductItemModel> fetchProductDetails(String productId) async {
    final selectedProduct = await firestoreServices
        .getDocument<ProductItemModel>(
          path: ApiPaths.product(productId),
          builder:
              (data, documentId) => ProductItemModel.fromMap(
                data,
                documentId: documentId,
              ),
        );
    if (selectedProduct == null) {
      throw Exception('Product not found');
    }
    return selectedProduct;
  }
  
  @override
  Future<void> addToCart(AddToCartModel cartItem, String userId) async => await firestoreServices.setData(
    path: ApiPaths.cartItem(userId, cartItem.id),
    data: cartItem.toMap(),
  );
    
    
  
}
