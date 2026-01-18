

import 'package:animation_project/models/product_item_model.dart';

class AddToCartModel {
final String id;
final ProductItemModel product;
final ProductSize size;
final int quantity;


 const AddToCartModel({

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
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': product.toMap(),
      'size': size.name,
      'quantity': quantity,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'] as String,
      product: ProductItemModel.fromMap(map['product'] as Map<String,dynamic>),
      size: ProductSize.fromString(map['size'] as String),
      quantity: map['quantity'] as int,
    );
  }

 
}

List<AddToCartModel>dummyCart=[];