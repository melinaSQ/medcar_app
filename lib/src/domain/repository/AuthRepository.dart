import 'package:medcar_app/src/domain/models/AuthResponse.dart';
import 'package:medcar_app/src/domain/models/user.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';
// import 'package:medcar_app/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';

/* Aqui solo definimos los metodos y funciones a implementar mas adelante*/

abstract class AuthRepository {
  Future<Resource<AuthResponse>> login(String email, String password);
  Future<Resource<bool>> loginCar(int idDriver, String plate, String code);
  Future<Resource<AuthResponse>> register(User user);
  Future<void> saveUserSession(AuthResponse authResponse);
  Future<AuthResponse?> getUserSession();
  Future<bool> logout();
}
