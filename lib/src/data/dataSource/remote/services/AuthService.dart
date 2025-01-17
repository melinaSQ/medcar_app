// ignore: file_names
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:medcar_app/src/data/api/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'package:medcar_app/src/domain/models/AuthResponse.dart';
import 'package:medcar_app/src/domain/models/user.dart';
import 'package:medcar_app/src/domain/utils/ListToString.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';
import 'package:medcar_app/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';

class AuthService {
  //LOGINN DE USUARIO***********************
  Future<Resource<AuthResponse>> login(String email, String password) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/auth/login');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode({'email': email, 'password': password});
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      print('codigo de estado: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        print('Data Remote: ${authResponse.toJson()}');
        print('Token: ${authResponse.token}');
        return Success(authResponse);
      }
      // else {
      //   return ErrorData(listToString(data['message']));
      // }
      // Manejo de errores específicos

      else if (response.statusCode == 400) {
        // Ejemplo: credenciales inválidas

        return ErrorData(
            "Credenciales inválidas. Por favor, revisa tu email y contraseña.");
      } else if (response.statusCode == 404) {
        return ErrorData("Error 404: El recurso solicitado no fue encontrado.");
      } else if (response.statusCode == 401) {
        // Ejemplo: no autorizado
        return ErrorData("No autorizado. Verifica tus credenciales.");
      } else if (response.statusCode == 500) {
        // Ejemplo: error interno del servidor
        return ErrorData("Error en el servidor. Intenta más tarde.");
      } else {
        // Otro tipo de error
        return ErrorData(
            "Error desconocido. Código de estado: ${response.statusCode}");
      }

      /*
      print('Data Remote: $data');
      return data;
      */
    } catch (e) {
      print('Error: $e');
      // return ErrorData(e.toString());
      return ErrorData("Error de conexión o de red: ${e.toString()}");
    }
  }

  Future<Resource<bool>> loginCar(
      int idDriver, String plate, String code) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/ambulances');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body =
          json.encode({'id_driver': idDriver, 'plate': plate, 'code': code});
      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);

      print('codigo de estado: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('Data Remote: ${assignDriver.tojson()}');
        String message = 'Ambulancia asignada con exito';
        print(message);

        return Success(true);
      } else if (response.statusCode == 400) {
        // Ejemplo: credenciales inválidas
        print('Error 400: ${response.body}');
        return ErrorData(
            "Credenciales inválidas. Por favor, revisa tu placa y codigo.");
        // } else if (response.statusCode == 404) {
        //   print('Error 404: ${response.body}');
        //   return ErrorData("Error 404: El recurso solicitado no fue encontrado.");
      } else if (response.statusCode == 401) {
        // Ejemplo: no autorizado
        print('Error 401: ${response.body}');
        return ErrorData("No autorizado. Verifica tus credenciales.");
      } else if (response.statusCode == 500) {
        // Ejemplo: error interno del servidor
        print('Error 500: ${response.body}');
        return ErrorData("Error en el servidor. Intenta más tarde.");
      } else {
        // Otro tipo de error
        print('ErrorData: ${ErrorData}');
        print('ErrorDatamessage: ${ErrorData(listToString(data['message']))}');
        print('Error Body: ${response.body}');
        return ErrorData("Error: ${response.body}");
      }

      /*
      print('Data Remote: $data');
      return data;
      */
    } catch (e, stackTrace) {
      print('Error Catch: $e');
      print('Stack trace: ${e.toString()}');
      print('StackTrace: $stackTrace');
      // return ErrorData(e.toString());
      return ErrorData("Error de conexión o de red: ${e.toString()}");
    }
  }

  //REGISTRRO DE USUARIO ************************
  Future<Resource<AuthResponse>> register(User user) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/auth/register');
      Map<String, String> headers = {'Content-Type': 'application/json'};

      String body = json.encode(user);

      final response = await http.post(url, headers: headers, body: body);

      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        print('Data Remote: ${authResponse.toJson()}');
        print('Token: ${authResponse.token}');
        return Success(authResponse);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }
}
