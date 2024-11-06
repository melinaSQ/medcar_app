// ignore_for_file: file_names

import 'dart:convert';

ClientRequest clientRequestFromJson(String str) => ClientRequest.fromJson(json.decode(str));

String clientRequestToJson(ClientRequest data) => json.encode(data.toJson());

class ClientRequest {
    int? id;
    int idClient;
    String patientData;
    DateTime pickupDate;
    double pickupLat;
    double pickupLng;
    double destinationLat;
    double destinationLng;
    String pickupDescription;
    String destinationDescription;

    ClientRequest({
        this.id,
        required this.idClient,
        required this.patientData,
        required this.pickupDate,
        required this.pickupLat,
        required this.pickupLng,
        required this.destinationLat,
        required this.destinationLng,
        required this.pickupDescription,
        required this.destinationDescription,
    });

    factory ClientRequest.fromJson(Map<String, dynamic> json) => ClientRequest(
        id: json["id"],
        idClient: json["id_client"],
        patientData: json["patient_data"],
        pickupDate: DateTime.parse(json["pickup_date"]),
        pickupLat: json["pickup_lat"]?.toDouble(),
        pickupLng: json["pickup_lng"]?.toDouble(),
        destinationLat: json["destination_lat"]?.toDouble(),
        destinationLng: json["destination_lng"]?.toDouble(),
        pickupDescription: json["pickup_description"],
        destinationDescription: json["destination_description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "patient_data": patientData,
        "pickup_date": pickupDate.toIso8601String(),
        "pickup_lat": pickupLat,
        "pickup_lng": pickupLng,
        "destination_lat": destinationLat,
        "destination_lng": destinationLng,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
    };
}