// ignore_for_file: file_names

// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcar_app/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:medcar_app/blocSocketIO/BlocSocketIOState.dart';
// import 'package:medcar_app/main.dart';
// import 'package:medcar_app/src/domain/models/AuthResponse.dart';
// import 'package:medcar_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:medcar_app/src/domain/useCases/socket/SocketUseCases.dart';
import 'package:socket_io_client/socket_io_client.dart';

class BlocSocketIO extends Bloc<BlocSocketIOEvent, BlocSocketIOState> {
  SocketUseCases socketUseCases;
  // AuthUseCases authUseCases;

  BlocSocketIO(
    this.socketUseCases,
    // this.authUseCases,
  ) : super(BlocSocketIOState()) {
    //events
    on<ConnectSocketIO>((event, emit) {
      Socket socket = socketUseCases.connect.run();
      emit(
        state.copyWith(socket: socket),
      );
    });

    on<DisconnectSocketIO>((event, emit) {
      socketUseCases.disconnect.run();
      emit(
        state.copyWith(socket: null),
      );
    });

    // on<ListenDriverAssignedSocketIO>((event, emit) async {
    //   if (state.socket != null) {
    //     AuthResponse authResponse = await authUseCases.getUserSession.run();
    //     state.socket?.on('driver_assigned/${authResponse.user.id}', (data) {
    //       print('DATA: $data');
    //       navigatorKey.currentState?.pushNamed('driver/map/trip',
    //           arguments: data['id_client_request']);
    //     });
    //   }
    // });
  }
}
