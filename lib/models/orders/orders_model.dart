class OrdersModel {
  final bool status;

  final Data data;

  OrdersModel({
    required this.status,
    required this.data,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  // Map<String, dynamic> toJson() => {
  //     "status": status,
  //     "message": message,
  //     "data": data.toJson(),
  // };
}

class Data {
  // final int currentPage;
  final List<Order> orders;
  // final String firstPageUrl;
  // final int from;
  // final int lastPage;
  // final String lastPageUrl;
  // final dynamic nextPageUrl;
  // final String path;
  // final int perPage;
  // final dynamic prevPageUrl;
  // final int to;
  final int total;

  Data({
    // required this.currentPage,
    required this.orders,
    // required this.firstPageUrl,
    // required this.from,
    // required this.lastPage,
    // required this.lastPageUrl,
    // required this.nextPageUrl,
    // required this.path,
    // required this.perPage,
    // required this.prevPageUrl,
    // required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        // currentPage: json["current_page"],
        orders: json["data"] != null
            ? List<Order>.from(json["data"].map((x) => Order.fromJson(x)))
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
        total: json["total"],
      );

  // Map<String, dynamic> toJson() => {
  //     "current_page": currentPage,
  //     "data": List<dynamic>.from(data.map((x) => x.toJson())),
  //     "first_page_url": firstPageUrl,
  //     "from": from,
  //     "last_page": lastPage,
  //     "last_page_url": lastPageUrl,
  //     "next_page_url": nextPageUrl,
  //     "path": path,
  //     "per_page": perPage,
  //     "prev_page_url": prevPageUrl,
  //     "to": to,
  //     "total": total,
  // };
}

class Order {
  final int id;
  final double total;
  final String date;
  String status;

  Order({
    required this.id,
    required this.total,
    required this.date,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        total: json["total"]?.toDouble(),
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "date": date,
        "status": status,
      };
}
