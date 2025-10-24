import 'package:animation_project/models/product_item_model.dart';

class AddToCartModel {
final String id;
final ProductItemModel product;
final ProductSize size;
final int quantity;


  AddToCartModel( {

    required this.product,
     required this.size,
      required this.quantity,
     required this.id, 
    
      
      });

AddToCartModel copyWith({
  String? productId,
ProductSize?size,
 int?quantity
}){
  return AddToCartModel(
    id: id,
    product: product,
     size:size?? this.size,
      quantity:quantity?? this.quantity,
      
      );
}


double get totalPrice=> product.price*quantity;
  
}

List<AddToCartModel>dummyCart=[];