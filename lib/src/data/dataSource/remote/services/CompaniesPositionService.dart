// ignore_for_file: file_names, avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medcar_app/src/data/api/ApiConfig.dart';
import 'package:medcar_app/src/domain/models/CompanyPosition.dart';
import 'package:medcar_app/src/domain/models/DriverPosition.dart';
import 'package:medcar_app/src/domain/utils/ListToString.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';

class CompaniesPositionService {
  Future<Resource<bool>> create(CompanyPosition companyPosition) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/drivers-position');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode(companyPosition);
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

   Future<Resource<DriverPosition>> getDriverPosition(int idDriver) async {

    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/drivers-position/${idDriver}');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        DriverPosition driverPosition = DriverPosition.fromJson(data);
        return Success(driverPosition);
      }
      else {
        return ErrorData(listToString(data['message']));
      }

    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }

   }

  Future<Resource<bool>> delete(int idDriver) async {
    try {
      Uri url =
          Uri.http(ApiConfig.API_PROJECT, '/drivers-position/${idDriver}');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final response = await http.delete(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }
}
