import 'dart:convert';

import 'package:flutter_tools/utilities/extension_methods.dart';

enum PropertyType { Motorcycle, Tricycle, Car, Truck }

enum PaymentFrequency { Daily, Weekly, Monthly, Yearly }

enum ContractType { WorkAndPay, Continuous, TrackExpenses }

enum PropertyStatus { CONNECTING, VERIFYING, READY, ONGOING, PAUSED, COMPLETED }

enum VerificationStatus { Unset, Pending, Verified, Rejected, Expired }

enum ManagementType { None, Managed, Partner }

class Property {
  int userId;
  String plateNumber;
  String propertyType;
  String contractType;
  num amountAgreed;
  num totalExpected;
  num deposit;
  String paymentFrequency;
  DateTime startDate;
  int companyId;
  int guarantorsNeeded;
  int expectedSalesCount;
  Rider? rider;
  String propertyStatus;
  DateTime createdAt;
  DateTime? updatedAt;
  int id;

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
        rider: json["rider"] != null ? Rider.fromMap(json["rider"]) : null,
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

  static List<Property> parseToGetList(dynamic responseBody) =>
      responseBody.map<Property>((json) => Property.fromMap(json)).toList();
}

class Rider {
  String phoneNumber;
  String fullName;
  String photoUrl;
  String verificationStatus;
  DateTime expiryDate;
  List<Guarantor> guarantors;
  int id;

  Rider({
    required this.phoneNumber,
    required this.fullName,
    required this.photoUrl,
    required this.verificationStatus,
    required this.expiryDate,
    this.guarantors = const [],
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
        verificationStatus: json["verificationStatus"],
        expiryDate: DateTime.parse(json["expiryDate"]),
      );

  Map<String, dynamic> toMap() => {
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "photoUrl": photoUrl,
        "guarantors": List<dynamic>.from(guarantors.map((x) => x.toMap())),
        "id": id,
        "verificationStatus": verificationStatus,
        "expiryDate": expiryDate.toIso8601String(),
      };
}

class Guarantor {
  String phoneNumber;
  String fullName;
  String photoUrl;
  int id;
  int riderId;
  int propertyId;

  Guarantor({
    required this.id,
    required this.phoneNumber,
    required this.fullName,
    required this.photoUrl,
    required this.riderId,
    required this.propertyId,
  });

  factory Guarantor.fromJson(String str) => Guarantor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Guarantor.fromMap(Map<String, dynamic> json) => Guarantor(
        phoneNumber: json["phoneNumber"],
        fullName: json["fullName"],
        photoUrl: json["photoUrl"],
        id: json["id"],
        riderId: json["riderId"],
        propertyId: json["propertyId"],
      );

  Map<String, dynamic> toMap() => {
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "photoUrl": photoUrl,
        "id": id,
        "riderId": riderId,
        "propertyId": propertyId,
      };
}

class Sale {
  String description;
  num amount;
  DateTime dueDate;
  int riderId;
  int propertyId;
  String plateNumber;
  String saleStatus;
  String paymentRef;
  int invoiceId;
  String chargeStatus;
  String partnerChargeStatus;
  DateTime createdAt;
  DateTime? updatedAt;
  int id;

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

  static List<Sale> parseToGetList(dynamic responseBody) =>
      responseBody.map<Sale>((json) => Sale.fromMap(json)).toList();
}

class Company {
  int id;
  String name;
  String email;
  String role;
  bool isActive;

  Company({
    required this.id,
    required this.name,
    required this.email,
    required this.isActive,
    required this.role,
  });

  factory Company.fromJson(String str) => Company.fromJson(json.decode(str));
  String toJson() => json.encode(toJson());

  factory Company.fromMap(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        isActive: json["isActive"],
        role: json["role"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "isActive": isActive,
        "role": role,
      };

  static List<Company> parseToGetList(dynamic responseBody) =>
      responseBody.map<Company>((json) => Company.fromMap(json)).toList();
}

class AssetOverview {
  double amountAgreed;
  double totalExpected;
  double deposit;
  double paid;
  double paidPercentage;
  int propertyId;
  double remaining;
  int expectedSalesCount;
  int paidSalesCount;
  int leftSalesCount;

  AssetOverview({
    this.amountAgreed = 0,
    this.totalExpected = 0,
    this.deposit = 0,
    this.paid = 0,
    this.paidPercentage = 0,
    this.propertyId = 0,
    this.remaining = 0,
    this.expectedSalesCount = 0,
    this.paidSalesCount = 0,
    this.leftSalesCount = 0,
  });

  factory AssetOverview.fromMap(Map<String, dynamic> json) => AssetOverview(
        amountAgreed: json["amountAgreed"],
        totalExpected: json["totalExpected"],
        deposit: json["deposit"],
        paid: json["paid"],
        paidPercentage: json["paidPercentage"],
        propertyId: json["propertyId"],
        remaining: json["remaining"],
        expectedSalesCount: json["expectedSalesCount"],
        paidSalesCount: json["paidSalesCount"],
        leftSalesCount: json["leftSalesCount"],
      );

  Map<String, dynamic> toMap() => {
        "amountAgreed": amountAgreed,
        "totalExpected": totalExpected,
        "deposit": deposit,
        "paid": paid,
        "paidPercentage": paidPercentage,
        "propertyId": propertyId,
        "remaining": remaining,
        "expectedSalesCount": expectedSalesCount,
        "paidSalesCount": paidSalesCount,
        "leftSalesCount": leftSalesCount,
      };
}

class AccountOverviewMini {
  num expectedSales;
  num paidSales;
  num leftSales;
  int propertyCount;
  int expectedSalesCount;
  int paidSalesCount;
  int leftSalesCount;
  int companyId;
  int riderId;
  DateTime date;

  AccountOverviewMini({
    required this.expectedSales,
    required this.paidSales,
    required this.leftSales,
    required this.propertyCount,
    required this.expectedSalesCount,
    required this.paidSalesCount,
    required this.leftSalesCount,
    required this.companyId,
    required this.riderId,
    required this.date,
  });

  factory AccountOverviewMini.fromJson(String str) =>
      AccountOverviewMini.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountOverviewMini.fromMap(Map<String, dynamic> json) =>
      AccountOverviewMini(
        expectedSales: json["expectedSales"],
        paidSales: json["paidSales"],
        leftSales: json["leftSales"],
        propertyCount: json["propertyCount"],
        expectedSalesCount: json["expectedSalesCount"],
        paidSalesCount: json["paidSalesCount"],
        leftSalesCount: json["leftSalesCount"],
        companyId: json["companyId"],
        riderId: json["riderId"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "expectedSales": expectedSales,
        "paidSales": paidSales,
        "leftSales": leftSales,
        "propertyCount": propertyCount,
        "expectedSalesCount": expectedSalesCount,
        "paidSalesCount": paidSalesCount,
        "leftSalesCount": leftSalesCount,
        "companyId": companyId,
        "riderId": riderId,
        "date": date.toIso8601String(),
      };
}

class Expense {
  String description;
  num amount;
  DateTime date;
  int propertyId;
  DateTime createdAt;
  DateTime? updatedAt;
  int id;

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
  String? email;
  DateTime since;
  DateTime expiry;
  String profile;
  String photoUrl;
  String idCardStatus;
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
    this.email,
    required this.since,
    required this.profile,
    this.photoUrl = '',
    this.idCardStatus = '',
    required this.plannedSales,
    required this.hoursToUnpaid,
    required this.expiry,
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
        photoUrl: json["photoUrl"],
        idCardStatus: json["idCardStatus"],
        expiry: DateTime.parse(json["expiry"]),
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
        "expiry": expiry.toIso8601String(),
        "profile": profile,
        "plannedSales": plannedSales,
        "hoursToUnpaid": hoursToUnpaid,
        "photoUrl": photoUrl,
        "idCardStatus": idCardStatus,
      };

  bool get isOwner => profile.containsIgnoreCase('owner');

  bool get isRider => profile.containsIgnoreCase('rider');

  bool get isIdCardInvalid =>
      idCardStatus.toLowerCase() !=
          VerificationStatus.Verified.name.toLowerCase() ||
      expiry.isBefore(DateTime.now());

  bool get isIdCardPending =>
      idCardStatus.toLowerCase() ==
      VerificationStatus.Pending.name.toLowerCase();
}

class AccountOverview {
  int companyId;
  num totalEarnings;
  int totalPropertyCount;
  int totalPaidSalesCount;
  int totalExpendituresCount;
  num totalExpenditures;
  num bikeEarnings;
  int bikeCount;
  int bikeSalesCount;
  int bikeExpendituresCount;
  num bikeExpenditures;
  num carEarnings;
  int carCount;
  int carSalesCount;
  int carExpendituresCount;
  num carExpenditures;
  num trucEarnings;
  int trucCount;
  int trucSalesCount;
  int trucExpendituresCount;
  num trucExpenditures;
  num tricycleEarnings;
  int tricycleCount;
  int tricycleSalesCount;
  int tricycleExpendituresCount;
  num tricycleExpenditures;
  num availableBalance;
  DateTime createdAt;
  DateTime? updatedAt;
  int id;

  AccountOverview({
    required this.companyId,
    required this.totalEarnings,
    required this.totalPropertyCount,
    required this.totalPaidSalesCount,
    required this.totalExpendituresCount,
    required this.totalExpenditures,
    required this.bikeEarnings,
    required this.bikeCount,
    required this.bikeSalesCount,
    required this.bikeExpendituresCount,
    required this.bikeExpenditures,
    required this.carEarnings,
    required this.carCount,
    required this.carSalesCount,
    required this.carExpendituresCount,
    required this.carExpenditures,
    required this.trucEarnings,
    required this.trucCount,
    required this.trucSalesCount,
    required this.trucExpendituresCount,
    required this.trucExpenditures,
    required this.tricycleEarnings,
    required this.tricycleCount,
    required this.tricycleSalesCount,
    required this.tricycleExpendituresCount,
    required this.tricycleExpenditures,
    required this.availableBalance,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory AccountOverview.fromJson(String str) =>
      AccountOverview.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccountOverview.fromMap(Map<String, dynamic> json) => AccountOverview(
        companyId: json["companyId"],
        totalEarnings: json["totalEarnings"],
        totalPropertyCount: json["totalPropertyCount"],
        totalPaidSalesCount: json["totalPaidSalesCount"],
        totalExpendituresCount: json["totalExpendituresCount"],
        totalExpenditures: json["totalExpenditures"],
        bikeEarnings: json["bikeEarnings"],
        bikeCount: json["bikeCount"],
        bikeSalesCount: json["bikeSalesCount"],
        bikeExpendituresCount: json["bikeExpendituresCount"],
        bikeExpenditures: json["bikeExpenditures"],
        carEarnings: json["carEarnings"],
        carCount: json["carCount"],
        carSalesCount: json["carSalesCount"],
        carExpendituresCount: json["carExpendituresCount"],
        carExpenditures: json["carExpenditures"],
        trucEarnings: json["trucEarnings"],
        trucCount: json["trucCount"],
        trucSalesCount: json["trucSalesCount"],
        trucExpendituresCount: json["trucExpendituresCount"],
        trucExpenditures: json["trucExpenditures"],
        tricycleEarnings: json["tricycleEarnings"],
        tricycleCount: json["tricycleCount"],
        tricycleSalesCount: json["tricycleSalesCount"],
        tricycleExpendituresCount: json["tricycleExpendituresCount"],
        tricycleExpenditures: json["tricycleExpenditures"],
        availableBalance: json["availableBalance"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "companyId": companyId,
        "totalEarnings": totalEarnings,
        "totalPropertyCount": totalPropertyCount,
        "totalPaidSalesCount": totalPaidSalesCount,
        "totalExpendituresCount": totalExpendituresCount,
        "totalExpenditures": totalExpenditures,
        "bikeEarnings": bikeEarnings,
        "bikeCount": bikeCount,
        "bikeSalesCount": bikeSalesCount,
        "bikeExpendituresCount": bikeExpendituresCount,
        "bikeExpenditures": bikeExpenditures,
        "carEarnings": carEarnings,
        "carCount": carCount,
        "carSalesCount": carSalesCount,
        "carExpendituresCount": carExpendituresCount,
        "carExpenditures": carExpenditures,
        "trucEarnings": trucEarnings,
        "trucCount": trucCount,
        "trucSalesCount": trucSalesCount,
        "trucExpendituresCount": trucExpendituresCount,
        "trucExpenditures": trucExpenditures,
        "tricycleEarnings": tricycleEarnings,
        "tricycleCount": tricycleCount,
        "tricycleSalesCount": tricycleSalesCount,
        "tricycleExpendituresCount": tricycleExpendituresCount,
        "tricycleExpenditures": tricycleExpenditures,
        "availableBalance": availableBalance,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };
}
