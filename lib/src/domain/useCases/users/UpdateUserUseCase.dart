// ignore_for_file: file_names

import 'dart:io';

import 'package:medcar_app/src/domain/models/user.dart';
import 'package:medcar_app/src/domain/repository/UsersRepository.dart';

class UpdateUserUseCase {

  UsersRepository usersRepository;

  UpdateUserUseCase(this.usersRepository);

  run(int id, User user, File? file) => usersRepository.update(id, user, file);

}