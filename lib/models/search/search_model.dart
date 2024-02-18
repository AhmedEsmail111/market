import '../home/home_model.dart';

class SearchModel {
  final bool status;

  final SearchData searchData;

  SearchModel({
    required this.status,
    required this.searchData,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        status: json["status"],
        searchData: json["data"] != null
            ? SearchData.fromJson(json["data"])
            : SearchData(currentPage: 1, productData: []),
      );
}

class SearchData {
  final int currentPage;
  final List<Product> productData;
  // final String firstPageUrl;
  // final int from;
  // final int lastPage;
  // final String lastPageUrl;
  // final dynamic nextPageUrl;
  // final String path;
  // final int perPage;
  // final dynamic prevPageUrl;
  // final int to;
  // final int total;

  SearchData({
    required this.currentPage,
    required this.productData,
    // required this.firstPageUrl,
    // required this.from,
    // required this.lastPage,
    // required this.lastPageUrl,
    // required this.nextPageUrl,
    // required this.path,
    // required this.perPage,
    // required this.prevPageUrl,
    // required this.to,
    // required this.total,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        currentPage: json["current_page"] ?? 1,
        productData: json["data"] != null
            ? List<Product>.from(
                json["data"].map((product) => Product.fromJson(product)))
            : [],
        // firstPageUrl: json["first_page_url"],
        // from: json["from"],
        // lastPage: json["last_page"],
        // lastPageUrl: json["last_page_url"],
        // nextPageUrl: json["next_page_url"],
        // path: json["path"],
        // perPage: json["per_page"],
        // prevPageUrl: json["prev_page_url"],
        // to: json["to"],
        // total: json["total"],
      );
}

// class ProductData {
//   final int id;
//   final double price;
//   final String image;
//   final String name;
//   final String description;
//   final List<String> images;
//   final bool inFavorites;
//   final bool inCart;

//   ProductData({
//     required this.id,
//     required this.price,
//     required this.image,
//     required this.name,
//     required this.description,
//     required this.images,
//     required this.inFavorites,
//     required this.inCart,
//   });

//   factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
//         id: json["id"] ?? 1,
//         price: json["price"]?.toDouble() ?? 2.0,
//         image: json["image"] ?? '',
//         name: json["name"] ?? '',
//         description: json["description"] ?? '',
//         images: json["images"] != null
//             ? List<String>.from(json["images"].map((x) => x))
//             : [],
//         inFavorites: json["in_favorites"] ?? false,
//         inCart: json["in_cart"] ?? false,
//       );
// }
