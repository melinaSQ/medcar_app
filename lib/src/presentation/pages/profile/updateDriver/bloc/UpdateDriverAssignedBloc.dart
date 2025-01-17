// // ignore_for_file: unused_import, file_names, avoid_print
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:medcar_app/src/domain/models/AuthResponse.dart';
// import 'package:medcar_app/src/domain/useCases/auth/AuthUseCases.dart';
// import 'package:medcar_app/src/domain/useCases/users/UsersUseCases.dart';
// import 'package:medcar_app/src/domain/utils/Resource.dart';
// import 'package:medcar_app/src/presentation/pages/profile/updateDriver/bloc/UpdateDriverAssignedEvent.dart';
// import 'package:medcar_app/src/presentation/pages/profile/updateDriver/bloc/UpdateDriverAssignedState.dart';
// import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';

// class UpdateDriverAssignedBloc extends Bloc<UpdateDriverAssignedEvent, UpdateDriverAssignedState> {
//   AuthUseCases authUseCases;
//   UsersUseCases usersUseCases;
//   final formKey = GlobalKey<FormState>();

//   UpdateDriverAssignedBloc(this.usersUseCases, this.authUseCases)
//       : super(UpdateDriverAssignedState()) {
//     //
//     //eventos
//     on<UpdateDriverAssignedInitEvent>((event, emit) {
//       AuthResponse? authResponse = authUseCases.getUserSession.run();

//       emit(state.copyWith(
//         id: authResponse.user.id,
//         formKey: formKey,
//       ));
//     });
//     on<CarPlateChanged>((event, emit) {
//       // event.email  LO QUE EL USUARIO ESTA ESCRIBIENDO
//       emit(state.copyWith(
//           plate: BlocFormItem(
//               value: event.plate.value,
//               error: event.plate.value.isEmpty
//                   ? 'Ingresa la placa vehicular'
//                   : null),
//           formKey: formKey));
//     });

//     on<CodeChanged>((event, emit) {
//       emit(state.copyWith(
//           code: BlocFormItem(
//               value: event.code.value,
//               error: event.code.value.isEmpty ? 'Ingresa el password' : null),
//           formKey: formKey));
//     });

//     on<UpdateDriverAssigned>((event, emit) async {
//       AuthResponse authResponse = await authUseCases.getUserSession.run();
//       authResponse.user.name = event.user.name;
//       authResponse.user.lastname = event.user.lastname;
//       authResponse.user.phone = event.user.phone;
//       authResponse.user.image = event.user.image;
//       await authUseCases.saveUserSession.run(authResponse);
//     });

//     on<FormSubmit>((event, emit) async {
//       print('ingreso al form submit');
//       print('id user: ${state.userId}');
//       print('Plate: ${state.plate.value}');
//       print('Code: ${state.code.value}');

//       emit(
//         state.copyWith(
//           response: Loading(),
//           formKey: formKey,
//         ),
//       );

//       Resource response =
//           await usersUseCases.update.run(state.id, state.toUser(), state.image);

//       // Resource response = await authUseCases.loginCar
//       //     .run(state.userId!, state.plate.value, state.code.value);

//       print('response carbloc: ${response}');

//       emit(
//         state.copyWith(
//           response: response,
//           formKey: formKey,
//         ),
//       );
//     });
//   }
// }
