// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/AuthRepository.dart';

class LoginUseCase {
  
  AuthRepository repository;

  LoginUseCase(this.repository);

  run(String email, String password) => repository.login(email, password);
  
}