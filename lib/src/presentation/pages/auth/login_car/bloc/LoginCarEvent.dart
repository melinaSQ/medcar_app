// ignore_for_file: file_names

import 'package:medcar_app/src/domain/models/AuthResponse.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';

abstract class LoginCarEvent {}

class LoginCarInitEvent extends LoginCarEvent {}

class CarPlateChanged extends LoginCarEvent {
  final BlocFormItem plate;
  CarPlateChanged({ required this.plate });
}

class CodeChanged extends LoginCarEvent {
  final BlocFormItem code;
  CodeChanged({ required this.code });
}

class SaveUserSession extends LoginCarEvent {
  final AuthResponse authResponse;
  SaveUserSession({ required this.authResponse });
}

class UpdateNotificationToken extends LoginCarEvent {
  final int id;
  UpdateNotificationToken({required this.id});
}

class FormSubmit extends LoginCarEvent {}