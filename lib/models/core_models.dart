import 'dart:convert';

import 'package:flutter_tools/utilities/extension_methods.dart';

enum PropertyType { Motorcycle, Tricycle, Car, Truck }

enum PaymentFrequency { Daily, Weekly, Monthly, Yearly }

enum ContractType { WorkAndPay, Continuous }

enum PropertyStatus { CONNECTING, VERIFYING, READY, ONGOING, PAUSED, COMPLETED }

class Property {
  final int userId;
  final String plateNumber;
  final String propertyType;
  final String contractType;
  final int amountAgreed;
  final int totalExpected;
  final int deposit;
  final String paymentFrequency;
  final DateTime startDate;
  final int companyId;
  final int guarantorsNeeded;
  final int expectedSalesCount;
  final Rider? rider;
  final String propertyStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int id;

  Property({
    required this.userId,
    required this.plateNumber,
    required this.propertyType,
    required this.contractType,
    required this.amountAgreed,
    required this.totalExpected,
    required this.deposit,
    required this.paymentFrequency,
    required this.startDate,
    required this.companyId,
    required this.guarantorsNeeded,
    required this.expectedSalesCount,
    this.rider,
    required this.propertyStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  // factory Property fromJson(String str) => Property.fromJson(json.decode(str));
  factory Property.fromJson(String str) => Property.fromJson(json.decode(str));

  String toJson() => json.encode(toJson());

  factory Property.fromMap(Map<String, dynamic> json) => Property(
        userId: json["userId"],
        plateNumber: json["plateNumber"],
        propertyType: json["propertyType"],
        contractType: json["contractType"],
        amountAgreed: json["amountAgreed"],
        totalExpected: json["totalExpected"],
        deposit: json["deposit"],
        paymentFrequency: json["paymentFrequency"],
        startDate: DateTime.parse(json["startDate"]),
        companyId: json["companyId"],
        guarantorsNeeded: json["guarantorsNeeded"],
        expectedSalesCount: json["expectedSalesCount"],
        rider: Rider.fromMap(json["rider"]),
        propertyStatus: json["propertyStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "plateNumber": plateNumber,
        "propertyType": propertyType,
        "contractType": contractType,
        "amountAgreed": amountAgreed,
        "totalExpected": totalExpected,
        "deposit": deposit,
        "paymentFrequency": paymentFrequency,
        "startDate": startDate.toIso8601String(),
        "companyId": companyId,
        "guarantorsNeeded": guarantorsNeeded,
        "expectedSalesCount": expectedSalesCount,
        "rider": rider?.toMap(),
        "propertyStatus": propertyStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };
}

class Rider {
  final String phoneNumber;
  final String fullName;
  final String photoUrl;
  final List<Guarantor> guarantors;
  final int id;

  Rider({
    required this.phoneNumber,
    required this.fullName,
    required this.photoUrl,
    required this.guarantors,
    required this.id,
  });

  factory Rider.fromJson(String str) => Rider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rider.fromMap(Map<String, dynamic> json) => Rider(
        phoneNumber: json["phoneNumber"],
        fullName: json["fullName"],
        photoUrl: json["photoUrl"],
        guarantors: List<Guarantor>.from(
            json["guarantors"].map((x) => Guarantor.fromMap(x))),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "photoUrl": photoUrl,
        "guarantors": List<dynamic>.from(guarantors.map((x) => x.toMap())),
        "id": id,
      };
}

class Guarantor {
  final String phoneNumber;
  final String fullName;
  final String photoUrl;

  Guarantor({
    required this.phoneNumber,
    required this.fullName,
    required this.photoUrl,
  });

  factory Guarantor.fromJson(String str) => Guarantor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Guarantor.fromMap(Map<String, dynamic> json) => Guarantor(
        phoneNumber: json["phoneNumber"],
        fullName: json["fullName"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toMap() => {
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "photoUrl": photoUrl,
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
  final String chargeStatus;
  final String partnerChargeStatus;
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
    required this.chargeStatus,
    required this.partnerChargeStatus,
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
        chargeStatus: json["chargeStatus"],
        partnerChargeStatus: json["partnerChargeStatus"],
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
        "partnerChargeStatus": partnerChargeStatus,
        "chargeStatus": chargeStatus,
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

class OverviewData {
  double amountAgreed;
  double totalExpected;
  double deposit;
  double paid;
  double paidPercentage;
  int propertyId;
  double remaining;

  OverviewData({
    this.amountAgreed = 0,
    this.totalExpected = 0,
    this.deposit = 0,
    this.paid = 0,
    this.paidPercentage = 0,
    this.propertyId = 0,
    this.remaining = 0,
  });

  factory OverviewData.fromMap(Map<String, dynamic> json) => OverviewData(
        amountAgreed: json["amountAgreed"],
        totalExpected: json["totalExpected"],
        deposit: json["deposit"],
        paid: json["paid"],
        paidPercentage: json["paidPercentage"],
        propertyId: json["propertyId"],
        remaining: json["remaining"],
      );

  Map<String, dynamic> toMap() => {
        "amountAgreed": amountAgreed,
        "totalExpected": totalExpected,
        "deposit": deposit,
        "paid": paid,
        "paidPercentage": paidPercentage,
        "propertyId": propertyId,
        "remaining": remaining,
      };
}

class Expense {
  final String description;
  final int amount;
  final DateTime date;
  final int propertyId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int id;

  Expense({
    required this.description,
    required this.amount,
    required this.date,
    required this.propertyId,
    required this.createdAt,
    this.updatedAt,
    required this.id,
  });

  factory Expense.fromJson(String str) => Expense.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Expense.fromMap(Map<String, dynamic> json) => Expense(
        description: json["description"],
        amount: json["amount"],
        date: DateTime.parse(json["date"]),
        propertyId: json["propertyId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "amount": amount,
        "date": date.toIso8601String(),
        "propertyId": propertyId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };
}

class UserData {
  UserData({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        user: User.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "token": token,
      };
}

class User {
  int ownerId;
  int riderId;
  int companyId;
  bool isRiderActive;
  bool isOwnerActive;
  String surname;
  String otherNames;
  String phoneNumber;
  String email;
  DateTime since;
  String profile;
  int plannedSales;
  int hoursToUnpaid;

  User({
    required this.ownerId,
    required this.riderId,
    required this.companyId,
    required this.isRiderActive,
    required this.isOwnerActive,
    required this.surname,
    required this.otherNames,
    required this.phoneNumber,
    required this.email,
    required this.since,
    required this.profile,
    required this.plannedSales,
    required this.hoursToUnpaid,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        ownerId: json["ownerId"],
        riderId: json["riderId"],
        companyId: json["companyId"],
        isRiderActive: json["isRiderActive"],
        isOwnerActive: json["isOwnerActive"],
        surname: json["surname"],
        otherNames: json["otherNames"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        since: DateTime.parse(json["since"]),
        profile: json["profile"],
        plannedSales: json["plannedSales"],
        hoursToUnpaid: json["hoursToUnpaid"],
      );

  Map<String, dynamic> toMap() => {
        "ownerId": ownerId,
        "riderId": riderId,
        "companyId": companyId,
        "isRiderActive": isRiderActive,
        "isOwnerActive": isOwnerActive,
        "surname": surname,
        "otherNames": otherNames,
        "phoneNumber": phoneNumber,
        "email": email,
        "since": since.toIso8601String(),
        "profile": profile,
        "plannedSales": plannedSales,
        "hoursToUnpaid": hoursToUnpaid,
      };

  bool get isOwner => profile.containsIgnoreCase('owner');

  bool get isRider => profile.containsIgnoreCase('rider');
}
