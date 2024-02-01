class ChangeFavoriteModel {
  final bool status;
  final String message;

  factory ChangeFavoriteModel.fromJson(Map<String, dynamic> json) =>
      ChangeFavoriteModel(
        status: json["status"],
        message: json["message"],
      );

  ChangeFavoriteModel({
    required this.status,
    required this.message,
  });
}
