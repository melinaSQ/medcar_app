// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/AuthRepository.dart';

class LoginCarUseCase {
  
  AuthRepository repository;

  LoginCarUseCase(this.repository);

  run(int idDriver, String plate, String code) => repository.loginCar(idDriver, plate, code);
  
}