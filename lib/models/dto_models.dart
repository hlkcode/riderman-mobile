import 'dart:convert';

class PropertyDto {
  String plateNumber;
  int propertyType;
  int contractType;
  int amountAgreed;
  int totalExpected;
  int deposit;
  int paymentFrequency;
  DateTime startDate;
  int companyId;
  int guarantorsNeeded;
  int managementType;
  String riderPhoneNumber;

  PropertyDto({
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
    required this.managementType,
    required this.riderPhoneNumber,
  });

  factory PropertyDto.fromJson(String str) =>
      PropertyDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PropertyDto.fromMap(Map<String, dynamic> json) => PropertyDto(
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
        managementType: json["managementType"],
        riderPhoneNumber: json["riderPhoneNumber"],
      );

  Map<String, dynamic> toMap() => {
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
        "managementType": managementType,
        "riderPhoneNumber": riderPhoneNumber,
      };
}

class UserCreateDto {
  String phoneNumber;
  String surname;
  String otherNames;
  String password;
  String? email;
  String? promoCode;
  String companyName;
  String profile;
  bool isCompany;

  UserCreateDto({
    required this.phoneNumber,
    required this.surname,
    required this.otherNames,
    required this.password,
    this.email,
    this.promoCode,
    required this.companyName,
    required this.profile,
    required this.isCompany,
  });

  factory UserCreateDto.fromJson(String str) =>
      UserCreateDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserCreateDto.fromMap(Map<String, dynamic> json) => UserCreateDto(
        phoneNumber: json["phoneNumber"],
        surname: json["surname"],
        otherNames: json["otherNames"],
        password: json["password"],
        email: json["email"],
        promoCode: json["promoCode"],
        companyName: json["companyName"],
        profile: json["profile"],
        isCompany: json["isCompany"],
      );

  Map<String, dynamic> toMap() => {
        "phoneNumber": phoneNumber,
        "surname": surname,
        "otherNames": otherNames,
        "password": password,
        "email": email,
        "promoCode": promoCode,
        "companyName": companyName,
        "profile": profile,
        "isCompany": isCompany,
      };

  bool get canLogin =>
      phoneNumber.isNotEmpty && password.isNotEmpty && profile.isNotEmpty;
}
