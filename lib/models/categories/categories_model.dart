class CategoriesModel {
  final List<Category> data;

  CategoriesModel({
    required this.data,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        data: List<Category>.from(
            json["data"]["data"].map((cat) => Category.fromJson(cat))),
      );
}

class Category {
  final int id;
  final String name;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );
}
