// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/medcar_apploc.dart';
import 'package:medcar_app/blocSocketIO/BlocSocketIO.dart';
import 'package:medcar_app/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:medcar_app/main.dart';
import 'package:medcar_app/src/presentation/pages/auth/login/LoginPage.dart';
// import 'package:medcar_app/src/presentation/pages/client/mapSeeker/ClientMapSeekerPage.dart';
// import 'package:medcar_app/src/presentation/pages/driver/carInfo/DriverCarInfoPage.dart';
import 'package:medcar_app/src/presentation/pages/driver/clientRequests/DriverClientRequestsPage.dart';
// import 'package:medcar_app/src/presentation/pages/driver/historyTrip/DriverHistoryTripPage.dart';
import 'package:medcar_app/src/presentation/pages/driver/home/bloc/DriverHomeBloc.dart';
import 'package:medcar_app/src/presentation/pages/driver/home/bloc/DriverHomeState.dart';
import 'package:medcar_app/src/presentation/pages/driver/home/bloc/DriverHomeEvent.dart';
import 'package:medcar_app/src/presentation/pages/driver/mapLocation/DriverMapLocationPage.dart';
import 'package:medcar_app/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:medcar_app/src/presentation/pages/roles/RolesPage.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  List<Widget> pageList = <Widget>[
    DriverMapLocationPage(),
    DriverClientRequestsPage(),
    // DriverCarInfoPage(),
    // DriverHistoryTripPage(),
    ProfileInfoPage(),
    RolesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu de opciones',
        ),
      ),
      body: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        },
      ),
      drawer: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: const [
                        Color.fromARGB(255, 12, 38, 145),
                        Color.fromARGB(255, 34, 156, 249),
                      ],
                    ),
                  ),
                  child: Text(
                    'Menu del Conductor',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text('Mapa de localizacion'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 0));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Solicitudes de viaje'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 1));
                    Navigator.pop(context);
                  },
                ),
                // ListTile(
                //   title: Text('Mi Vehiculo'),
                //   selected: state.pageIndex == 2,
                //   onTap: () {
                //     context
                //         .read<DriverHomeBloc>()
                //         .add(ChangeDrawerPage(pageIndex: 2));
                //     Navigator.pop(context);
                //   },
                // ),
                // ListTile(
                //   title: Text('Historial de viajes'),
                //   selected: state.pageIndex == 3,
                //   onTap: () {
                //     context
                //         .read<DriverHomeBloc>()
                //         .add(ChangeDrawerPage(pageIndex: 3));
                //     Navigator.pop(context);
                //   },
                // ),
                ListTile(
                  title: Text('Perfil del usuario'),
                  selected: state.pageIndex == 2,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 2));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Roles de usuario'),
                  selected: state.pageIndex == 3,
                  onTap: () {
                    context
                        .read<DriverHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 3));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Cerrar sesion'),
                  onTap: () {
                    // context.read<DriverHomeBloc>().add(Logout());
                    // context.read<BlocSocketIO>().add(DisconnectSocketIO());
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => MyApp()),
                    //     (route) => false);
                    try {
                      print('entro al try del boton cerrar sesion');
                      context.read<DriverHomeBloc>().add(Logout());
                      context.read<BlocSocketIO>().add(DisconnectSocketIO());

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (Route<dynamic> route) =>
                              false, // Elimina todas las rutas previas
                        );
                      });

                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => MyApp()),
                      //     (route) => false);
                    } catch (e, stackTrace) {
                      print('Error en el cierre de sesión: $e');
                      print(stackTrace);
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
