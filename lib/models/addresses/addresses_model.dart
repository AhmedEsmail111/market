class AddressesModel {
  final bool status;

  final List<Address> data;

  AddressesModel({
    required this.status,
    required this.data,
  });

  factory AddressesModel.fromJson(Map<String, dynamic> json) => AddressesModel(
        status: json["status"],
        data: json["data"]["data"].isNotEmpty
            ? List<Address>.from(
                json["data"]["data"]?.map(
                  (data) => Address.fromJson(data),
                ),
              )
            : [],
      );
}

class Address {
  final int id;
  final String name;
  final String city;
  final String region;
  final String details;
  final String? notes;
  final dynamic phone;

  Address({
    required this.id,
    required this.name,
    required this.city,
    required this.region,
    required this.details,
    required this.notes,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        region: json["region"],
        details: json["details"],
        notes: json["notes"],
        phone: json["latitude"]?.toDouble(),
      );
}
