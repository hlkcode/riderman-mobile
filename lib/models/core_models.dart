import 'dart:convert';

enum PropertyType { Motorcycle, Tricycle, Car, Truck }

enum PaymentFrequency { Daily, Weekly, Monthly, Yearly }

enum ContractType { WorkAndPay, Continuous }

enum PropertyStatus { CONNECTING, VERIFYING, READY, ONGOING, PAUSED, COMPLETED }

class Property {
  final String plateNumber;
  final String riderPhoneNumber;
  final String propertyType;
  final String contractType;
  final int amountAgreed;
  final int totalExpected;
  final int deposit;
  final String paymentFrequency;
  final DateTime startDate;
  final int companyId;
  final int userId;
  final String propertyStatus;
  final int expectedSalesCount;
  final int guarantorsNeeded;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int id;

  Property({
    required this.plateNumber,
    required this.riderPhoneNumber,
    required this.propertyType,
    required this.contractType,
    required this.amountAgreed,
    required this.totalExpected,
    required this.deposit,
    required this.paymentFrequency,
    required this.startDate,
    required this.companyId,
    required this.userId,
    required this.propertyStatus,
    required this.expectedSalesCount,
    required this.guarantorsNeeded,
    required this.createdAt,
    this.updatedAt,
    required this.id,
  });

  factory Property.fromJson(String str) => Property.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Property.fromMap(Map<String, dynamic> json) => Property(
        plateNumber: json["plateNumber"],
        riderPhoneNumber: json["riderPhoneNumber"],
        propertyType: json["propertyType"],
        contractType: json["contractType"],
        amountAgreed: json["amountAgreed"],
        totalExpected: json["totalExpected"],
        deposit: json["deposit"],
        paymentFrequency: json["paymentFrequency"],
        startDate: DateTime.parse(json["startDate"]),
        companyId: json["companyId"],
        userId: json["userId"],
        propertyStatus: json["propertyStatus"],
        expectedSalesCount: json["expectedSalesCount"],
        guarantorsNeeded: json["guarantorsNeeded"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "plateNumber": plateNumber,
        "riderPhoneNumber": riderPhoneNumber,
        "propertyType": propertyType,
        "contractType": contractType,
        "amountAgreed": amountAgreed,
        "totalExpected": totalExpected,
        "deposit": deposit,
        "paymentFrequency": paymentFrequency,
        "startDate": startDate.toIso8601String(),
        "companyId": companyId,
        "userId": userId,
        "propertyStatus": propertyStatus,
        "expectedSalesCount": expectedSalesCount,
        "guarantorsNeeded": guarantorsNeeded,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };
}

class Sale {
  final String description;
  final int amount;
  final DateTime dueDate;
  final int riderId;
  final int propertyId;
  final String plateNumber;
  final String saleStatus;
  final String paymentRef;
  final int invoiceId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int id;

  Sale({
    required this.description,
    required this.amount,
    required this.dueDate,
    required this.riderId,
    required this.propertyId,
    required this.plateNumber,
    required this.saleStatus,
    required this.paymentRef,
    required this.invoiceId,
    required this.createdAt,
    this.updatedAt,
    required this.id,
  });

  factory Sale.fromMap(Map<String, dynamic> json) => Sale(
        description: json["description"],
        amount: json["amount"],
        dueDate: DateTime.parse(json["dueDate"]),
        riderId: json["riderId"],
        propertyId: json["propertyId"],
        plateNumber: json["plateNumber"],
        saleStatus: json["saleStatus"],
        paymentRef: json["paymentRef"],
        invoiceId: json["invoiceId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "amount": amount,
        "dueDate": dueDate.toIso8601String(),
        "riderId": riderId,
        "propertyId": propertyId,
        "plateNumber": plateNumber,
        "saleStatus": saleStatus,
        "paymentRef": paymentRef,
        "invoiceId": invoiceId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };

  Sale fromJson(String str) => Sale.fromMap(json.decode(str));

  String toJson(Sale data) => json.encode(data.toMap());
}

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
