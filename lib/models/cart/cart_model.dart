import '../home/home_model.dart';

class CartModel {
  final bool status;
  final Data data;

  CartModel({
    required this.status,
    required this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final List<CartItem> cartItems;
  final num subTotal;
  final num total;

  Data({
    required this.cartItems,
    required this.subTotal,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cartItems: ["cart_items"].isNotEmpty
            ? List<CartItem>.from(
                json["cart_items"].map((x) => CartItem.fromJson(x)))
            : [],
        subTotal: json["sub_total"],
        total: json["total"],
      );
}

class CartItem {
  final int id;
  final int quantity;
  final Product product;

  CartItem({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
      );
}

// class Product {
//     final int id;
//     final int price;
//     final int oldPrice;
//     final int discount;
//     final String image;
//     final String name;
//     final String description;
//     final List<String> images;
//     final bool inFavorites;
//     final bool inCart;

//     Product({
//         required this.id,
//         required this.price,
//         required this.oldPrice,
//         required this.discount,
//         required this.image,
//         required this.name,
//         required this.description,
//         required this.images,
//         required this.inFavorites,
//         required this.inCart,
//     });

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         price: json["price"],
//         oldPrice: json["old_price"],
//         discount: json["discount"],
//         image: json["image"],
//         name: json["name"],
//         description: json["description"],
//         images: List<String>.from(json["images"].map((x) => x)),
//         inFavorites: json["in_favorites"],
//         inCart: json["in_cart"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "price": price,
//         "old_price": oldPrice,
//         "discount": discount,
//         "image": image,
//         "name": name,
//         "description": description,
//         "images": List<dynamic>.from(images.map((x) => x)),
//         "in_favorites": inFavorites,
//         "in_cart": inCart,
//     };
// }
