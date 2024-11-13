// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/AuthRepository.dart';

class GetUserSessionUseCase {

  AuthRepository authRepository;

  GetUserSessionUseCase(this.authRepository);

  run() => authRepository.getUserSession();

}