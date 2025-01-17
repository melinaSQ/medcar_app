// ignore_for_file: file_names


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';

class UpdateDriverAssignedState extends Equatable {
  final int id;
  final BlocFormItem plate;
  final BlocFormItem code;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const UpdateDriverAssignedState({
    this.id = 0,
    this.plate = const BlocFormItem(error: 'Ingresa la placa del vehículo'),
    this.code = const BlocFormItem(error: 'Ingresa el codigo de verificación'),
    this.formKey,
    this.response,
  });

  // toUser() => User(
  //   id: name.value,
  //   plate: lastname.value,
  //   code: phone.value
  // );

  UpdateDriverAssignedState copyWith(
      {int? id,
      BlocFormItem? plate,
      BlocFormItem? code,
      GlobalKey<FormState>? formKey,
      Resource? response}) {
    return UpdateDriverAssignedState(
        id: id ?? this.id,
        plate: plate ?? this.plate,
        code: code ?? this.code,
        formKey: formKey,
        response: response);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        plate,
        code,
        response,
      ];
}
