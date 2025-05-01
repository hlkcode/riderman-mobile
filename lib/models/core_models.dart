import 'dart:convert';

class Company {
  final int id;
  final String name;
  final String email;
  final bool isActive;

  Company({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
  });

  factory Company.fromJson(String str) => Company.fromJson(json.decode(str));

  String toJson() => json.encode(toJson());

  factory Company.fromMap(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "isActive": isActive,
      };
}
