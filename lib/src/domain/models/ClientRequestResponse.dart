// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:medcar_app/src/domain/models/DriverCarInfo.dart';

ClientRequestResponse clientRequestResponseFromJson(String str) =>
    ClientRequestResponse.fromJson(json.decode(str));

String clientRequestResponseToJson(ClientRequestResponse data) =>
    json.encode(data.toJson());

class ClientRequestResponse {
  int id;
  int idClient;
  String pickupDescription;
  String destinationDescription;
  DateTime updatedAt;
  DateTime? createdAt;
  Position pickupPosition;
  Position destinationPosition;
  double? distance;
  String? timeDifference;
  Client client;
  Client? driver;
  GoogleDistanceMatrix? googleDistanceMatrix;
  int? idDriverAssigned;
  double? fareAssigned;
  DriverCarInfo? car;
  String patientData; // Nuevo parámetro
  DateTime pickUpTime; // Nuevo parámetro

  ClientRequestResponse({
    required this.id,
    required this.idClient,
    required this.pickupDescription,
    required this.destinationDescription,
    required this.updatedAt,
    this.createdAt,
    required this.pickupPosition,
    required this.destinationPosition,
    this.distance,
    this.timeDifference,
    required this.client,
    this.googleDistanceMatrix,
    this.fareAssigned,
    this.idDriverAssigned,
    this.driver,
    this.car,
    required this.patientData, // Agregar al constructor
    required this.pickUpTime, // Agregar al constructor
  });

  static List<ClientRequestResponse> fromJsonList(List<dynamic> jsonList) {
    List<ClientRequestResponse> toList = [];
    jsonList.forEach((json) {
      ClientRequestResponse clientRequestResponse =
          ClientRequestResponse.fromJson(json);
      toList.add(clientRequestResponse);
    });
    return toList;
  }

  factory ClientRequestResponse.fromJson(Map<String, dynamic> json) =>
      ClientRequestResponse(
        id: json["id"],
        idClient: json["id_client"],
        pickupDescription: json["pickup_description"],
        destinationDescription: json["destination_description"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        pickupPosition: Position.fromJson(json["pickup_position"]),
        destinationPosition: Position.fromJson(json["destination_position"]),
        distance: json["distance"]?.toDouble(),
        timeDifference: json["time_difference"],
        client: Client.fromJson(json["client"]),
        driver: json["driver"] != null ? Client.fromJson(json["driver"]) : null,
        idDriverAssigned: json["id_driver_assigned"],
        fareAssigned: json["fare_assigned"]?.toDouble(),
        googleDistanceMatrix: json["google_distance_matrix"] != null
            ? GoogleDistanceMatrix.fromJson(json["google_distance_matrix"])
            : null,
        car: json["car"] != null ? DriverCarInfo.fromJson(json["car"]) : null,
        patientData: json["patient_data"] ??
            "", // Asegúrate de que el JSON tenga este campo
        pickUpTime: DateTime.parse(json["pick_up_time"]), // Asegúrate
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
        "updated_at": updatedAt.toIso8601String(),
        "pickup_position": pickupPosition.toJson(),
        "destination_position": destinationPosition.toJson(),
        "distance": distance,
        "time_difference": timeDifference,
        "client": client.toJson(),
        "google_distance_matrix": googleDistanceMatrix?.toJson(),
        "id_driver_assigned": idDriverAssigned,
        "fare_assigned": fareAssigned,
        "driver": driver,
        "car": car?.toJson(), "patient_data": patientData, // Incluir en toJson
        "pick_up_time": pickUpTime, // Incluir en toJson
      };
}

class Client {
  String name;
  dynamic image;
  String phone;
  String lastname;

  Client({
    required this.name,
    required this.image,
    required this.phone,
    required this.lastname,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        name: json["name"],
        image: json["image"],
        phone: json["phone"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "phone": phone,
        "lastname": lastname,
      };
}

class Position {
  double x;
  double y;

  Position({
    required this.x,
    required this.y,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}

class GoogleDistanceMatrix {
  Distance distance;
  Distance duration;
  String status;

  GoogleDistanceMatrix({
    required this.distance,
    required this.duration,
    required this.status,
  });

  factory GoogleDistanceMatrix.fromJson(Map<String, dynamic> json) =>
      GoogleDistanceMatrix(
        distance: Distance.fromJson(json["distance"]),
        duration: Distance.fromJson(json["duration"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance.toJson(),
        "duration": duration.toJson(),
        "status": status,
      };
}

class Distance {
  String text;
  int value;

  Distance({
    required this.text,
    required this.value,
  });

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: json["text"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
      };
}
