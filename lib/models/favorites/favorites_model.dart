import '../home/home_model.dart';

class FavoritesModel {
  final bool status;

  final List<Data> data;

  FavoritesModel({
    required this.status,
    required this.data,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) => FavoritesModel(
        status: json["status"],
        data: json["data"]["data"] != null
            ? List<Data>.from(
                json["data"]["data"]?.map(
                  (data) => Data.fromJson(data),
                ),
              )
            : [],
      );
}

class Data {
  final Product product;

  Data({
    required this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        product: Product.fromJson(json["product"]),
      );
}

// class Product {
//   final int id;
//   final double price;
//   final double? oldPrice;
//   final int? discount;
//   final String image;
//   final String name;
//   final String description;

//   Product({
//     required this.id,
//     required this.price,
//     required this.oldPrice,
//     required this.discount,
//     required this.image,
//     required this.name,
//     required this.description,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         price: json["price"]?.toDouble(),
//         oldPrice: json["old_price"]?.toDouble(),
//         discount: json["discount"],
//         image: json["image"],
//         name: json["name"],
//         description: json["description"],
//       );
// }
