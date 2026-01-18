import 'package:animation_project/models/product_item_model.dart';
import 'package:animation_project/services/firestore_services.dart';
import 'package:animation_project/utils/api_pathes.dart';

abstract class FavoriteServices {
  Future<void>addFavorite(String userId, ProductItemModel product);
  Future<void>removeFavorite(String userId, String productId);
  Future<List<ProductItemModel>>getFavorites(String userId);
}
class FavoriteServicesImpl implements FavoriteServices {
 
  final FirestoreServices firestoreServices = FirestoreServices.instance;

  @override
  Future<void> addFavorite(String userId, ProductItemModel product) async {
    await firestoreServices.setData(path:ApiPaths.favoriteProduct(userId,product.id)
     ,data: product.toMap());
  
  }

  @override
  Future<void> removeFavorite(String userId, String productId) async {
    await firestoreServices.deleteData(path: ApiPaths.favoriteProduct(userId, productId ));
  }

  @override
  Future<List<ProductItemModel>> getFavorites(String userId) async => 
  await firestoreServices.getCollection(path: ApiPaths.favoriteProducts(userId),
   builder: (data, documentId) => ProductItemModel.fromMap(data));

  
}