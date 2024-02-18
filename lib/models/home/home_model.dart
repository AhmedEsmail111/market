import 'dart:convert' as convert_json;

class HomeModel {
  final List<Product> products;

  HomeModel({
    required this.products,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        products: List<Product>.from(
          json["products"].map(
            (product) => Product.fromJson(product),
          ),
        ),
      );
}

// class Banner {
//   final int id;
//   final String image;
//   final dynamic category;
//   final dynamic product;

//   Banner({
//     required this.id,
//     required this.image,
//     required this.category,
//     required this.product,
//   });

//   factory Banner.fromJson(Map<String, dynamic> json) => Banner(
//         id: json["id"],
//         image: json["image"],
//         category: json["category"],
//         product: json["product"],
//       );
// }

class Product {
  final int id;
  final double price;
  final double? oldPrice;
  final int? discount;
  final String image;
  final String? name;
  final String description;
  final List<String> images;
  final bool? inFavorites;
  final bool? inCart;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });
// images could be a string encoded or a list or strings or even null
//and inFavorites and inCart could be int representing booleans or could be normal true or false values
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"]?.toDouble(),
        oldPrice: json["old_price"]?.toDouble(),
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"] ?? '',
        images: json["images"] != null
            ? json["images"] is String
                ? List<String>.from(convert_json.json
                    .decode(json["images"])
                    .map((image) => image))
                : List<String>.from(json["images"].map((image) => image))
            : [json["image"], json["image"], json["image"], json["image"]],
        inFavorites: json["in_favorites"] is int
            ? json["in_favorites"] == 0
                ? true
                : false
            : json["in_favorites"],
        inCart: json["in_favorites"] is int
            ? json["in_favorites"] == 0
                ? true
                : false
            : json["in_favorites"],
      );
}
