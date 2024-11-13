//import 'package:firebase_messaging/firebase_messaging.dart';
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcar_app/src/domain/models/AuthResponse.dart';
import 'package:medcar_app/src/domain/useCases/auth/AuthUseCases.dart';
// import 'package:medcar_app/src/domain/useCases/auth/LoginUseCase.dart';
//import 'package:medcar_app/src/domain/useCases/users/UsersUseCases.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';
import 'package:medcar_app/src/presentation/pages/auth/login_car/bloc/LoginCarEvent.dart';
import 'package:medcar_app/src/presentation/pages/auth/login_car/bloc/LoginCarState.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';

class LoginCarBloc extends Bloc<LoginCarEvent, LoginCarState> {
  AuthUseCases authUseCases;
  //UsersUseCases usersUseCases;

  final formKey = GlobalKey<FormState>();

  LoginCarBloc(
    this.authUseCases,
    /*this.usersUseCases*/
  ) : super(LoginCarState()) {
    on<LoginCarInitEvent>((event, emit) async {
      AuthResponse? authResponse = await authUseCases.getUserSession.run();
      print('Auth Response Session: ${authResponse?.toJson()}');

      emit(state.copyWith(formKey: formKey));
      if (authResponse != null) {
        emit(state.copyWith(response: Success(authResponse), formKey: formKey));
      }
    });

    on<SaveUserSession>((event, emit) async {
      await authUseCases.saveUserSession.run(event.authResponse);
    });

    on<CarPlateChanged>((event, emit) {
      // event.email  LO QUE EL USUARIO ESTA ESCRIBIENDO
      emit(state.copyWith(
          plate: BlocFormItem(
              value: event.plate.value,
              error: event.plate.value.isEmpty
                  ? 'Ingresa la placa vehicular'
                  : null),
          formKey: formKey));
    });

    on<CodeChanged>((event, emit) {
      emit(state.copyWith(
          code: BlocFormItem(
              value: event.code.value,
              error: event.code.value.isEmpty ? 'Ingresa el password' : null),
          formKey: formKey));
    });

    on<FormSubmit>((event, emit) async {
      print('Plate: ${state.plate.value}');
      print('Code: ${state.code.value}');

      emit(state.copyWith(response: Loading(), formKey: formKey));

//areglar
      Resource response =
          await authUseCases.login.run(state.plate.value, state.code.value);

      emit(state.copyWith(response: response, formKey: formKey));
    });

    /*
    on<UpdateNotificationToken>((event, emit) async {
      try {
        String? token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          Resource response = await usersUseCases.updateNotificationToken.run(event.id, token);
        }  
      } catch (e) {
        print('ERROR ACTUALIZANDO TOKEN: $e');
      }
      
    });
    */
  }
}
