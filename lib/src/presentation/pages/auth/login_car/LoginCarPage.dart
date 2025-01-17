// ignore_for_file: unnecessary_string_interpolations, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medcar_app/blocSocketIO/BlocSocketIO.dart';
import 'package:medcar_app/blocSocketIO/BlocSocketIOEvent.dart';
// import 'package:medcar_app/src/domain/models/AuthResponse.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';
import 'package:medcar_app/src/presentation/pages/auth/login_car/LoginCarContent.dart';
import 'package:medcar_app/src/presentation/pages/auth/login_car/bloc/LoginCarBloc.dart';
// import 'package:medcar_app/src/presentation/pages/auth/login_car/bloc/LoginCarEvent.dart';
import 'package:medcar_app/src/presentation/pages/auth/login_car/bloc/LoginCarState.dart';

class LoginCarPage extends StatefulWidget {
  const LoginCarPage({super.key});

  @override
  State<LoginCarPage> createState() => _LoginCarPageState();
}

class _LoginCarPageState extends State<LoginCarPage> {
  // HOT RELOAD - CTRL + S
  // HOT RESTART -
  // FULL RESTART

  @override
  Widget build(BuildContext context) {
    // print('Response LoginCarPage: ${response}');

    return Scaffold(
        body: BlocListener<LoginCarBloc, LoginCarState>(
      listener: (context, state) {
        print('ENTRO AL LISTENER');

        final response = state.response;
        print('Response LoginCarPage: ${state.response}');

        if (response is ErrorData) {
          // if (response != 200 || response != 201) {
          Fluttertoast.showToast(
              msg: '${response.message}', toastLength: Toast.LENGTH_SHORT);
          print('Error Data LoginCarPage: ${response.message}');
        } else if (response is Success) {
          print('Success Dta LoginCarPage: ${response.data}');
          // final authResponse = response.data as AuthResponse;

          // context.read<LoginBloc>().add(UpdateNotificationToken(id: authResponse.user.id!));
          context.read<BlocSocketIO>().add(ConnectSocketIO());
          // context.read<BlocSocketIO>().add(ListenDriverAssignedSocketIO());
          Navigator.pushNamedAndRemoveUntil(
              context, 'driver/home', (route) => false);
          print('coductor assignado ');
        }
      },
      child: BlocBuilder<LoginCarBloc, LoginCarState>(
        builder: (context, state) {
          print('ENTRO AL BUILDER');

          final response = state.response;
          if (response is Loading) {
            return Stack(
              children: [
                LoginCarContent(state),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }

          return LoginCarContent(state);
        },
      ),
    ));
  }
}
