import 'package:medcar_app/src/domain/repository/AuthRepository.dart';

class LogoutUseCase {

  AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  run() => authRepository.logout();

}