// ignore: file_names
import 'dart:convert';
import 'package:medcar_app/src/data/api/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'package:medcar_app/src/domain/models/AuthResponse.dart';
import 'package:medcar_app/src/domain/models/user.dart';
import 'package:medcar_app/src/domain/utils/ListToString.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';

class AuthService {
  //LOGINN DE USUARIO***********************
  Future<Resource<AuthResponse>> login(String email, String password) async {
    try {
      Uri url = Uri.http(ApiConfig.API_PROJECT, '/auth/login');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode({'email': email, 'password': password});
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

      /*
      print('Data Remote: $data');
      return data;
      */
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
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
