// ignore_for_file: file_names, avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medcar_app/src/data/api/ApiConfig.dart';
import 'package:medcar_app/src/domain/models/DriverTripRequest.dart';
import 'package:medcar_app/src/domain/utils/ListToString.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';

class DriverTripRequestsService {
  Future<Resource<bool>> create(DriverTripRequest driverTripRequest) async {
    print('info driver: ${driverTripRequest}');
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/driver-trip-offers');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode(driverTripRequest);
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error create-DriverTripRequestsService: $e');
      return ErrorData(e.toString());
    }
  }

  Future<Resource<List<DriverTripRequest>>> getDriverTripOffersByClientRequest(
      int idClientRequest) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT,
          '/driver-trip-offers/findByClientRequest/${idClientRequest}');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<DriverTripRequest> driverTripRequest =
            DriverTripRequest.fromJsonList(data);
        return Success(driverTripRequest);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e, stackTrace) {
      print(
          'Error en getDriverTripOffersByClientRequest-DriverTripRequestsService: $e');
      print('Stack trace: $stackTrace');
      return ErrorData(e.toString());
    }
  }
}
