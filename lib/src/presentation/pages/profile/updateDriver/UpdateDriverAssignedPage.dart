// // ignore_for_file: avoid_print, use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:medcar_app/src/domain/models/user.dart';
// import 'package:medcar_app/src/domain/utils/Resource.dart';
// import 'package:medcar_app/src/presentation/pages/profile/info/bloc/ProfileInfoBloc.dart';
// import 'package:medcar_app/src/presentation/pages/profile/info/bloc/ProfileInfoEvent.dart';
// import 'package:medcar_app/src/presentation/pages/profile/update/ProfileUpdateContent.dart';
// import 'package:medcar_app/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';
// import 'package:medcar_app/src/presentation/pages/profile/update/bloc/ProfileUpdateEvent.dart';
// import 'package:medcar_app/src/presentation/pages/profile/update/bloc/ProfileUpdateState.dart';

// class UpdateDriverAssignedPage extends StatefulWidget {
//   const UpdateDriverAssignedPage({super.key});

//   @override
//   State<UpdateDriverAssignedPage> createState() => _UpdateDriverAssignedPageState();
// }

// class _UpdateDriverAssignedPageState extends State<UpdateDriverAssignedPage> {
//   User? user;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print('METODO INIT STATE');
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       print('METODO INIT STATE BINDING');
//       context.read<ProfileUpdateBloc>().add(ProfileUpdateInitEvent(user: user));
      
//       print('user: $user');
      
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('METODO BUILD');
//     user = ModalRoute.of(context)?.settings.arguments as User;
//     return Scaffold(
//       body: BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
//         listener: (context, state) {
//           final response = state.response;
//           if (response is ErrorData) {
//             Fluttertoast.showToast(
//                 msg: response.message, toastLength: Toast.LENGTH_LONG);
//           } else if (response is Success) {
//             User user = response.data as User;
//             Fluttertoast.showToast(
//                 msg: 'Actualizacion exitosa', toastLength: Toast.LENGTH_LONG);
//             context
//                 .read<ProfileUpdateBloc>()
//                 .add(UpdateDriverAssigned(user: user));
//             Future.delayed(Duration(seconds: 1), () {
//               context.read<ProfileInfoBloc>().add(GetUserInfo());
//             });
//           }
//         },
//         child: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
//           builder: (context, state) {
//             final response = state.response;
//             if (response is Loading) {
//               return Stack(
//                 children: [
//                   ProfileUpdateContent(state, user),
//                   Center(child: CircularProgressIndicator())
//                 ],
//               );
//             }
//             return ProfileUpdateContent(state, user);
//           },
//         ),
//       ),
//     );
//   }
// }
