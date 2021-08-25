// model for donor
class Donor {
  String name = "unknown";
  String address = "";
  String phone = "";
  String email = "";
  String userId = "";

  Donor()
      : name = "unknown",
        address = "",
        phone = "",
        email = "",
        userId = "";

  Donor.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        address = json['address'],
        phone = json['phone'],
        email = json['email'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'phone': phone,
        'email': email,
        'userId': userId,
      };
}
