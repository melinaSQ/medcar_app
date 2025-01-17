
// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';

class LoginCarState extends Equatable {
  final BlocFormItem plate;
  final BlocFormItem code;
  final int? userId;
  final Resource? response;
  final GlobalKey<FormState>? formKey; //maneja el form

  const LoginCarState({
    this.plate = const BlocFormItem(error: 'Ingresa la placa del vehículo'),
    this.code = const BlocFormItem(error: 'Ingresa el codigo de verificación'),
    this.formKey,
    this.response,
    this.userId,
  });

  LoginCarState copyWith({
    BlocFormItem? plate,
    BlocFormItem? code,
    int? userId,
    Resource? response,
    GlobalKey<FormState>? formKey,
  }) {
    return LoginCarState(
        plate: plate ?? this.plate,
        code: code ?? this.code,
        userId: userId ?? this.userId,
        response: response,
        formKey: formKey);
  }

  @override
  List<Object?> get props => [
        plate,
        code,
        userId,
        response,
      ];
}
