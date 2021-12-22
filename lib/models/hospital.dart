// To parse this JSON data, do
//
//     final hospitalInfo = hospitalInfoFromMap(jsonString);

import 'dart:convert';

class HospitalInfo {
  HospitalInfo({
    this.key = "",
    this.hospitalName = "",
    this.hospitalAddress = "",
    this.helplinePhonenumber1 = "",
    this.helplinePhonenumber2 = "",
    this.totalGBeds = "",
    this.totalBedsGOxy = "",
    this.totalBedsGwOxy = "",
    this.totalIBeds = "",
    this.totalBedsGVenti = "",
    this.totalBedsGwVenti = "",
    this.currentBedsG = "",
    this.currentBedsGOxy = "",
    this.currentBedsGwOxy = "",
    this.currentBedsI = "",
    this.currentBedsGVenti = "",
    this.currentBedsGwVenti = "",
    this.district = "",
    this.taluka = "",
    this.timestmap = "",
  });
  final String key;
  String hospitalName;
  String hospitalAddress;
  String helplinePhonenumber1;
  String helplinePhonenumber2;
  String totalGBeds;
  String totalBedsGOxy;
  String totalBedsGwOxy;
  String totalIBeds;
  String totalBedsGVenti;
  String totalBedsGwVenti;
  String currentBedsG;
  String currentBedsGOxy;
  String currentBedsGwOxy;
  String currentBedsI;
  String currentBedsGVenti;
  String currentBedsGwVenti;
  String district;
  String taluka;
  String timestmap;

  // HospitalInfo.fromJson(this.key, Map data) {
  //   HospitalInfo.fromMap(data);
  // }
  // HospitalInfo.fromJson(this.key, String str) =>
  //     HospitalInfo.fromMap(this.key, json.decode(str));

  String toJson() => json.encode(toMap());

  factory HospitalInfo.fromMap(Map<String, dynamic> json) => HospitalInfo(
        hospitalName: json["hospitalName"],
        hospitalAddress: json["hospitalAddress"],
        helplinePhonenumber1: json["helplinePhonenumber1"],
        helplinePhonenumber2: json["helplinePhonenumber2"],
        totalGBeds: json["totalGBeds"],
        totalBedsGOxy: json["totalBedsGOxy"],
        totalBedsGwOxy: json["totalBedsGwOxy"],
        totalIBeds: json["totalIBeds"],
        totalBedsGVenti: json["totalBedsGVenti"],
        totalBedsGwVenti: json["totalBedsGwVenti"],
        currentBedsG: json["currentBedsG"],
        currentBedsGOxy: json["currentBedsGOxy"],
        currentBedsGwOxy: json["currentBedsGwOxy"],
        currentBedsI: json["currentBedsI"],
        currentBedsGVenti: json["currentBedsGVenti"],
        currentBedsGwVenti: json["currentBedsGwVenti"],
        district: json["district"],
        taluka: json["taluka"],
        timestmap: json["timestmap"],
      );

  Map<String, dynamic> toMap() => {
        "hospitalName": hospitalName,
        "hospitalAddress": hospitalAddress,
        "helplinePhonenumber1": helplinePhonenumber1,
        "helplinePhonenumber2": helplinePhonenumber2,
        "totalGBeds": totalGBeds,
        "totalBedsGOxy": totalBedsGOxy,
        "totalBedsGwOxy": totalBedsGwOxy,
        "totalIBeds": totalIBeds,
        "totalBedsGVenti": totalBedsGVenti,
        "totalBedsGwVenti": totalBedsGwVenti,
        "currentBedsG": currentBedsG,
        "currentBedsGOxy": currentBedsGOxy,
        "currentBedsGwOxy": currentBedsGwOxy,
        "currentBedsI": currentBedsI,
        "currentBedsGVenti": currentBedsGVenti,
        "currentBedsGwVenti": currentBedsGwVenti,
        "district": district,
        "taluka": taluka,
        "timestmap": timestmap,
      };
}
