// ignore_for_file: file_names

import 'dart:convert';

import 'package:medcar_app/src/domain/models/Ambulance.dart';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  int? id;
  int idUser;
  String name;
  String nit;
  String phone;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Ambulance>? ambulances;

  Company({
    this.id,
    required this.idUser,
    required this.name,
    required this.nit,
    required this.phone,
    this.createdAt,
    this.updatedAt,
    this.ambulances,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        idUser: json["id_user"],
        name: json["name"],
        nit: json["nit"],
        phone: json["phone"],
        ambulances: json["ambulances"] != null
            ? List<Ambulance>.from(
                json["ambulances"].map((x) => Ambulance.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "nit": nit,
        "phone": phone,
        "ambulances": ambulances != null
            ? List<dynamic>.from(ambulances!.map((x) => x.toJson()))
            : [],
      };
}
