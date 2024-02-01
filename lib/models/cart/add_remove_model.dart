import '../home/home_model.dart';

class AddRemoveCartModel {
  final bool status;
  final String message;
  final Data? data;

  AddRemoveCartModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddRemoveCartModel.fromJson(Map<String, dynamic> json) =>
      AddRemoveCartModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final int id;
  final int quantity;
  final Product product;

  Data({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
      );
}
