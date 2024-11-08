// ignore_for_file: file_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcar_app/src/domain/models/AuthResponse.dart';
import 'package:medcar_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:medcar_app/src/presentation/pages/driver/home/bloc/DriverHomeEvent.dart';
import 'package:medcar_app/src/presentation/pages/driver/home/bloc/DriverHomeState.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent, DriverHomeState> {
  AuthUseCases authUseCases;

  DriverHomeBloc(this.authUseCases) : super(DriverHomeState()) {
    on<ChangeDrawerPage>((event, emit) {
      emit(state.copyWith(pageIndex: event.pageIndex));
    });

    on<Logout>((event, emit) async {
      // await authUseCases.logout.run();
      try {

        //
        await authUseCases.logout.run();
        emit(
          DriverHomeState(pageIndex: 0),
        );

        AuthResponse? authResponse = await authUseCases.getUserSession.run();

        print(
            'Auth Response Session - driverhomebloc: ${authResponse?.toJson()}');
        // Redirige a la pantalla inicial o muestra la pantalla de login
      } catch (e) {
        // Maneja el error si no se puede hacer logout
        print("Error al hacer logout: $e");
      }
    });
  }
}
