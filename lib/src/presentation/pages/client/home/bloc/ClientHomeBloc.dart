// ignore_for_file: file_names

// import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcar_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:medcar_app/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:medcar_app/src/presentation/pages/client/home/bloc/ClientHomeState.dart';

class ClientHomeBloc extends Bloc<ClientHomeEvent, ClientHomeState> {
  AuthUseCases authUseCases;

  ClientHomeBloc(this.authUseCases) : super(ClientHomeState()) {
    on<ChangeDrawerPage>((event, emit) {
      emit(state.copyWith(pageIndex: event.pageIndex));
    });

    on<Logout>((event, emit) async {
      //await authUseCases.logout.run();
      try {
        // Ejecuta el caso de uso para cerrar sesión.
        final result = await authUseCases.logout.run();

        if (result) {
          // Aquí no necesitas cambiar el estado, solo realizas el logout.
          // El estado no cambiará, pero la UI tomará la acción adecuada.
          // Por lo tanto, no es necesario emitir un nuevo estado aquí.
          print("Sesion cerrada con exito");
        } else {
          // Si quieres manejar algún error, podrías hacer algo aquí, pero
          // no es obligatorio cambiar el estado en este punto.

          // ignore: avoid_print
          print("Error al cerrar sesión");
        }
      } catch (e) {
        // ignore: avoid_print
        print("Excepción al cerrar sesión: $e");
      }
    });
  }
}
