// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:convert';

import 'package:medcar_app/src/domain/models/Ambulance.dart';
import 'package:medcar_app/src/domain/models/user.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';

DriverTripRequest driverTripRequestFromJson(String str) =>
    DriverTripRequest.fromJson(json.decode(str));

String driverTripRequestToJson(DriverTripRequest data) =>
    json.encode(data.toJson());

class DriverTripRequest {
  int? id;
  int idDriver;
  int idClientRequest;
  double fareOffered;
  double time;
  double distance;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? driver;
  Ambulance? car;

  DriverTripRequest({
    this.id,
    required this.idDriver,
    required this.idClientRequest,
    required this.fareOffered,
    required this.time,
    required this.distance,
    this.createdAt,
    this.updatedAt,
    this.driver,
    this.car,
  });

  factory DriverTripRequest.fromJson(Map<String, dynamic> json) =>
      DriverTripRequest(
        id: json["id"],
        idDriver: json["id_driver"],
        idClientRequest: json["id_client_request"],
        fareOffered: json["fare_offered"] is String
            ? double.parse(json["fare_offered"])
            : json["fare_offered"],
        time:
            json["time"] is String ? double.parse(json["time"]) : json["time"],
        distance: json["distance"] is String
            ? double.parse(json['distance'])
            : json['distance'],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        driver: User.fromJson(json["driver"]),
        car: Ambulance.fromJson(json["car"]),
      );

  static List<DriverTripRequest> fromJsonList(List<dynamic> jsonList) {
    try{
print('entro al list from json de model driver trip');
    List<DriverTripRequest> toList = [];
    print('creo la lista');
    jsonList.forEach((json) {
      print('entro al bucle');

      print('Procesando elemento JSON: $json');
      //esta es la linea problema
      DriverTripRequest driverTripRequest = DriverTripRequest.fromJson(json);
      print('Elemento: $driverTripRequest');

      toList.add(driverTripRequest);

      print('Elemento añadido a la lista: $driverTripRequest');
      

    });
    print('lleno la lista');

    return toList;
    } catch (e, stackTrace) {
      print(
          'Error en DriverTripRequest-model: $e');
      print('Stack trace: $stackTrace');
      return [];
    }
    
  }

  Map<String, dynamic> toJson() => {
        "id_driver": idDriver,
        "id_client_request": idClientRequest,
        "fare_offered": fareOffered,
        "time": time,
        "distance": distance,
      };
}
