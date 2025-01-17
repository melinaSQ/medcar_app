// ignore_for_file: file_names

import 'dart:convert';

Ambulance ambulanceFromJson(String str) => Ambulance.fromJson(json.decode(str));

String ambulanceToJson(Ambulance data) => json.encode(data.toJson());

class Ambulance {
  int? id;
  int? idDriver;
  int? idCompany;
  String ambulanceType; // puede llegar como "ambulance_type" o "type"
  String plate;
  String? sedesResolutionCode;
  String? code;

  String? company;            // Nombre de la empresa

  Ambulance({
    this.id,
    this.idDriver,
    this.idCompany,
    required this.ambulanceType,
    required this.plate,
    this.sedesResolutionCode,
    this.code,
    this.company,
  });

  factory Ambulance.fromJson(Map<String, dynamic> json) => Ambulance(
        id: json["id"],
        idDriver: json["id_driver"],
        idCompany: json["id_company"],
        ambulanceType: json["ambulance_type"] ?? json["type"],
        plate: json["plate"],
        sedesResolutionCode: json["sedes_resolution_code"],
        code: json["code"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_driver": idDriver,
        "id_company": idCompany,
        "ambulance_type": ambulanceType,
        "plate": plate,
        "sedes_resolution_code": sedesResolutionCode,
        "code": code,
        "company": company,
      };
}
