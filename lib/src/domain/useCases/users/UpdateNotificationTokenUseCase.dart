// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/UsersRepository.dart';

class UpdateNotificationTokenUseCase {

  UsersRepository usersRepository;

  UpdateNotificationTokenUseCase(this.usersRepository);

  run(int id, String notificationToken) => usersRepository.updateNotificationToken(id, notificationToken);

}