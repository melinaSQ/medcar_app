import 'package:medcar_app/src/domain/models/user.dart';
import 'package:medcar_app/src/domain/repository/AuthRepository.dart';

class RegisterUseCase {

  AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  run(User user) => authRepository.register(user);
}