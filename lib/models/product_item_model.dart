enum ProductSize{
  S,
  M,
  L,
  // ignore: constant_identifier_names
  XL,
}

class ProductItemModel {
   final String id;
   final String name;
   final String imgUrl;
   final String description;
   final double price;
   final bool isFavorite;
   final String category;
final double averageRate;


  ProductItemModel({
    required this.id,
     required this.name,
      required this.imgUrl,
        this.description="lorem Ipsum simply dummy text of the printing and typssetting industy lorem Ipsum simply dummy text of the printing and typssetting industy lorem Ipsum simply dummy text of the printing and typssetting industy lorem Ipsum simply dummy text of the printing and typssetting industy.",
        required this.price,
          this.isFavorite=false,
          required this.category ,
          this.averageRate=4.5, 
          
         });

     ProductItemModel copyWith({
String? id,
  String? name,
   String? imgUrl,
    String? description,
   double? price,
    bool? isFavorite,
    String? category,
 double? averageRate,
 int? quantity,
 ProductSize? size,

}){

  return ProductItemModel(
    id: id??this.id,
     name: name??this.name,
      imgUrl: imgUrl??this.imgUrl, 
     price: price??this.price, 
     category: category??this.category,
     description: description??this.description,

     averageRate:averageRate??this.averageRate,
     isFavorite:isFavorite??this.isFavorite,
   
     );

}

}


List<ProductItemModel> dummyProducts = [
  ProductItemModel(
  
    id: 'K434118okA3XH70vmCgI',
    name: 'Black Shoes',
    imgUrl: 'images/pruducts_image/men_shoes_PNG7475.png',
    price: 20,
    category: 'Shoes',
    
  ),
  ProductItemModel(
    id: '3p6nOiAbCwlKNZkme7t2',
    name: 'T-shirt',
    imgUrl:
        'images/pruducts_image/tshirt.png',
    price: 30,
    category: 'Clothes',
  ),
  ProductItemModel(
    id: 'Y4xM7ukLvqRsurgioQmN',
    name: 'Pack of Tomatoes',
    imgUrl:
        'images/pruducts_image/tomato.png',
    price: 10,
    category: 'Groceries',
  ),
  ProductItemModel(
    id: 'OHncCKAImAwC9jg9XPam',
    name: 'Pack of Potatoes',
    imgUrl: 'images/pruducts_image/potato_png2398.png',
    price: 10,
    category: 'Groceries',
  ),
  ProductItemModel(
    id: '7WqSYwiEbed0G05zM72u',
    name: 'Pack of Onions',
    imgUrl: 'images/pruducts_image/onion_PNG99213.png',
    price: 10,
    category: 'Groceries',
  ),
  ProductItemModel(
    id: 'NQwKrejnxOFcgAzdkoQm',
    name: 'Pack of Apples',
    imgUrl: 'images/pruducts_image/apple.png',
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'uIVHYv1tLpiC3Jwik8b0',
    name: 'Pack of Oranges',
    imgUrl:
        'images/pruducts_image/orange.png',
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'BOQKlAc0GlRZXOmzcs1l',
    name: 'Pack of Bananas',
    imgUrl:
        'images/pruducts_image/banana.png',
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'atZHZfhF5glVKKO3XCtz',
    name: 'Pack of Mangoes',
    imgUrl: 'images/pruducts_image/pfrsich.png',
    price: 10,
    category: 'Fruits',
  ),
  ProductItemModel(
    id: 'jXDJxAUnBWJTXrOn5V1n',
    name: 'Sweet Shirt',
    imgUrl:
        'images/pruducts_image/wintershirt.png',
    price: 15,
    category: 'Clothes',
  ),
 
];
 