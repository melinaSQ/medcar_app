// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcar_app/main.dart';
// import 'package:medcar_app/blocSocketIO/BlocSocketIO.dart';
// import 'package:medcar_app/blocSocketIO/BlocSocketIOEvent.dart';
// import 'package:medcar_app/main.dart';
import 'package:medcar_app/src/presentation/pages/auth/login/LoginPage.dart';
//import 'package:medcar_app/src/presentation/pages/client/historyTrip/ClientHistoryTripPage.dart';
import 'package:medcar_app/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:medcar_app/src/presentation/pages/client/home/bloc/ClientHomeEvent.dart';
import 'package:medcar_app/src/presentation/pages/client/home/bloc/ClientHomeState.dart';
import 'package:medcar_app/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:medcar_app/src/presentation/pages/client/mapSeeker/ClientMapSeekerPage.dart';
import 'package:medcar_app/src/presentation/pages/roles/RolesPage.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  List<Widget> pageList = <Widget>[
    ClientMapSeekerPage(),
    //ClientHistoryTripPage(),
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
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft,
        //       colors: [
        //         Color.fromARGB(255, 12, 38, 145),
        //         Color.fromARGB(255, 34, 156, 249),
        //       ]
        //     ),
        //   )
        // ),
      ),
      body: BlocBuilder<ClientHomeBloc, ClientHomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        },
      ),
      drawer: BlocBuilder<ClientHomeBloc, ClientHomeState>(
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
                          /*
                            Color.fromARGB(255, 12, 38, 145),
                            Color.fromARGB(255, 34, 156, 249),
                            */
                          Color(0xFF652580), //morado kev
                          Color(0xFF5a469c), //morado
                          Color(0xFF00A099), //turquesa kev
                        ]),
                  ),
                  child: Text(
                    'Menu del cliente',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text('Mapa de busqueda'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context
                        .read<ClientHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 0));
                    Navigator.pop(context);
                  },
                ),
                /*
                ListTile(
                  title: Text('Historial de viajes'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context
                        .read<ClientHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 1));
                    Navigator.pop(context);
                  },
                ),
                */
                ListTile(
                  title: Text('Perfil del usuario'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context
                        .read<ClientHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 1));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Roles de usuario'),
                  selected: state.pageIndex == 2,
                  onTap: () {
                    context
                        .read<ClientHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 2));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Cerrar sesion'),
                  onTap: () {
                    // Despacha el evento de logout al Bloc.
                    context.read<ClientHomeBloc>().add(Logout());
                    //context.read<BlocSocketIO>().add(DisconnectSocketIO());

                    // Reinicia la aplicación o navega a la pantalla de login.
                    /*
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()), // O la pantalla de login si tienes una.
                      (route) => false, // Este argumento asegura que toda la pila de navegación se elimine.
                    );
                    */
                    print('entro al try del boton cerrar sesion');

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) =>
                            false, // Elimina todas las rutas previas
                      );
                    });
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
