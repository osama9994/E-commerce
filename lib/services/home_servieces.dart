import 'package:animation_project/models/category_model.dart';
import 'package:animation_project/models/home_carousel_item_model.dart';
import 'package:animation_project/models/product_item_model.dart';
import 'package:animation_project/services/firestore_services.dart';
import 'package:animation_project/utils/api_pathes.dart';


abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProducts();
  Future<List<HomeCarouselItemModel>>fetchHomeCarouselItems();
  Future<List<CategoryModel>>fetchCategories();
  // Future<List<ProductItemModel>>fetchFavoriteProducts(String userId);
  // Future<void> addFavoriteProduct({required String userId, required ProductItemModel product});
  // Future<void> removeFavoriteProduct({required String userId, required String productId});

}

class HomeServicesImpl implements HomeServices {
  final FirestoreServices firestoreServices = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchProducts() async {
    final result = await firestoreServices.getCollection<ProductItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) =>
          ProductItemModel.fromMap(data, documentId: documentId),
    );

    return result;
  }
  
  @override
  Future<List<HomeCarouselItemModel>> fetchHomeCarouselItems() async{
  final result = await firestoreServices.getCollection<HomeCarouselItemModel>(
      path: ApiPaths.announcements(),
      builder: (data, documentId) =>
          HomeCarouselItemModel.fromMap(data, documentId: documentId),
    );

    return result;
  }
  

  @override
  Future<List<CategoryModel>> fetchCategories()async {
 final result = await firestoreServices.getCollection<CategoryModel>(
      path: ApiPaths.categories(),
      builder: (data, documentId) =>
          CategoryModel.fromMap(data, documentId: documentId),
    );

    return result;
  }
  
  // @override
  // Future<void> addFavoriteProduct({required String userId, required ProductItemModel product})async =>
  // await firestoreServices.setData(path:ApiPaths.favoriteProduct(userId,product.id) ,data: product.toMap());
  
  // @override
  // Future<void> removeFavoriteProduct({required String userId, required String productId})async {
  // await firestoreServices.deleteData(path: ApiPaths.favoriteProduct(userId, productId));

  // }
  
  // @override
  // Future<List<ProductItemModel>> fetchFavoriteProducts(String userId)async {
  // final result = await firestoreServices.getCollection<ProductItemModel>(
  //     path: ApiPaths.favoriteProducts(userId),
  //     builder: (data, documentId) =>
  //         ProductItemModel.fromMap(data, documentId: documentId),
  //   );
  //   return result;
  // }
    
    
  
  



}