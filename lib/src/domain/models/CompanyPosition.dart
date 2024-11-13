// ignore_for_file: file_names

import 'dart:convert';

CompanyPosition companyPositionFromJson(String str) => CompanyPosition.fromJson(json.decode(str));

String driverPositionToJson(CompanyPosition data) => json.encode(data.toJson());

class CompanyPosition {
    int idCompany;
    double lat;
    double lng;

    CompanyPosition({
        required this.idCompany,
        required this.lat,
        required this.lng,
    });

    factory CompanyPosition.fromJson(Map<String, dynamic> json) => CompanyPosition(
        idCompany: json["id_driver"],
        lat: json["lat"],
        lng: json["lng"],
    );

    Map<String, dynamic> toJson() => {
        "id_company": idCompany,
        "lat": lat,
        "lng": lng,
    };
}
