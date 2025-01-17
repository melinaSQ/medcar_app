// ignore_for_file: file_names

import 'package:medcar_app/src/domain/models/user.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';

abstract class UpdateDriverAssignedEvent {}

class UpdateDriverAssignedInitEvent extends UpdateDriverAssignedEvent {
  // final User? user;
  // UpdateDriverAssignedInitEvent({ required this.user});
}

class CarPlateChanged extends UpdateDriverAssignedEvent {
  final BlocFormItem plate;
  CarPlateChanged({ required this.plate });
}

class CodeChanged extends UpdateDriverAssignedEvent {
  final BlocFormItem code;
  CodeChanged({ required this.code });
}

//arrelgar
class UpdateDriverAssigned extends UpdateDriverAssignedEvent {
  final User user;
  UpdateDriverAssigned({ required this.user });
}

class FormSubmit extends UpdateDriverAssignedEvent {}