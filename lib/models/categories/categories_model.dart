class CategoriesModel {
  final bool status;

  final List<Data> data;

  CategoriesModel({
    required this.status,
    required this.data,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        status: json["status"],
        data: List<Data>.from(
            json["data"]["data"].map((cat) => Data.fromJson(cat))),
      );
}

class Data {
  final int id;
  final String name;
  final String image;

  Data({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );
}
