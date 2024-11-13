// ignore_for_file: file_names, avoid_print

// import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcar_app/src/domain/models/AuthResponse.dart';
import 'package:medcar_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:medcar_app/src/presentation/pages/company/home/bloc/CompanyHomeEvent.dart';
import 'package:medcar_app/src/presentation/pages/company/home/bloc/CompanyHomeState.dart';

class CompanyHomeBloc extends Bloc<CompanyHomeEvent, CompanyHomeState> {
  AuthUseCases authUseCases;

  CompanyHomeBloc(this.authUseCases) : super(CompanyHomeState()) {
    on<ChangeDrawerPage>((event, emit) {
      emit(state.copyWith(pageIndex: event.pageIndex));
    });

    on<Logout>((event, emit) async {
      //await authUseCases.logout.run();
      try {
        // Ejecuta el caso de uso para cerrar sesión.
        final result = await authUseCases.logout.run();

        AuthResponse? authResponse = await authUseCases.getUserSession.run();

        print(
            'Auth Response Session - ClientHomeBloc: ${authResponse?.toJson()}');

        if (result) {
          // Aquí no necesitas cambiar el estado, solo realizas el logout.
          // El estado no cambiará, pero la UI tomará la acción adecuada.
          // Por lo tanto, no es necesario emitir un nuevo estado aquí.
          print("ClientHomeBloc: Sesion cerrada con exito");
        } else {
          // Si quieres manejar algún error, podrías hacer algo aquí, pero
          // no es obligatorio cambiar el estado en este punto.

          print("Error al cerrar sesión");
        }
      } catch (e) {
        print("Excepción al cerrar sesión: $e");
      }
    });
  }
}
