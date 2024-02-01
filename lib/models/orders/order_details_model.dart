import '../addresses/addresses_model.dart';
import '../home/home_model.dart';

class OrderDetailsModel {
  final bool status;
  final dynamic message;
  final Data data;

  OrderDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  // Map<String, dynamic> toJson() => {
  //     "status": status,
  //     "message": message,
  //     "data": data.toJson(),
  // };
}

class Data {
  final int id;
  final double cost;
  final int discount;
  final int points;
  final double vat;
  final double total;
  final int pointsCommission;
  final String promoCode;
  final String paymentMethod;
  final String date;
  final String status;
  final Address address;
  final List<Product> products;

  Data({
    required this.id,
    required this.cost,
    required this.discount,
    required this.points,
    required this.vat,
    required this.total,
    required this.pointsCommission,
    required this.promoCode,
    required this.paymentMethod,
    required this.date,
    required this.status,
    required this.address,
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        cost: json["cost"]?.toDouble(),
        discount: json["discount"],
        points: json["points"],
        vat: json["vat"]?.toDouble(),
        total: json["total"]?.toDouble(),
        pointsCommission: json["points_commission"],
        promoCode: json["promo_code"],
        paymentMethod: json["payment_method"],
        date: json["date"],
        status: json["status"],
        address: Address.fromJson(json["address"]),
        products: List<Product>.from(
            json["products"].map((product) => Product.fromJson(product))),
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "cost": cost,
  //     "discount": discount,
  //     "points": points,
  //     "vat": vat,
  //     "total": total,
  //     "points_commission": pointsCommission,
  //     "promo_code": promoCode,
  //     "payment_method": paymentMethod,
  //     "date": date,
  //     "status": status,
  //     "address": address.toJson(),
  //     "products": List<dynamic>.from(products.map((x) => x.toJson())),
  // };
}

// class Address {
//   final int id;
//   final String name;
//   final String city;
//   final String region;
//   final String details;
//   final String notes;
//   final int latitude;
//   final int longitude;

//   Address({
//     required this.id,
//     required this.name,
//     required this.city,
//     required this.region,
//     required this.details,
//     required this.notes,
//     required this.latitude,
//     required this.longitude,
//   });

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         id: json["id"],
//         name: json["name"],
//         city: json["city"],
//         region: json["region"],
//         details: json["details"],
//         notes: json["notes"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//       );

// Map<String, dynamic> toJson() => {
//       "id": id,
//       "name": name,
//       "city": city,
//       "region": region,
//       "details": details,
//       "notes": notes,
//       "latitude": latitude,
//       "longitude": longitude,
//     };
// }

// class Product {
//   final int id;
//   final int quantity;
//   final double price;
//   final String name;
//   final String image;

//   Product({
//     required this.id,
//     required this.quantity,
//     required this.price,
//     required this.name,
//     required this.image,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         quantity: json["quantity"],
//         price: json["price"]?.toDouble(),
//         name: json["name"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "quantity": quantity,
//         "price": price,
//         "name": name,
//         "image": image,
//       };
// }
