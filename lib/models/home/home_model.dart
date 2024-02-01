class HomeModel {
  final bool status;

  final Data data;

  HomeModel({
    required this.status,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final List<String> banners;
  final List<Product> products;
  final String ad;

  Data({
    required this.banners,
    required this.products,
    required this.ad,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banners:
            List<String>.from(json["banners"].map((banner) => banner["image"])),
        products: List<Product>.from(
            json["products"].map((product) => Product.fromJson(product))),
        ad: json["ad"],
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"]?.toDouble(),
        oldPrice: json["old_price"]?.toDouble(),
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"] ?? '',
        images: json["images"] != null
            ? List<String>.from(json["images"].map((image) => image))
            : [json["image"], json["image"], json["image"], json["image"]],
        inFavorites: json["in_favorites"],
        inCart: json["in_cart"],
      );
}
