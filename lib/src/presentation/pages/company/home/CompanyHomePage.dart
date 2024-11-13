// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medcar_app/main.dart';
import 'package:medcar_app/blocSocketIO/BlocSocketIO.dart';
import 'package:medcar_app/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:medcar_app/main.dart';
// import 'package:medcar_app/main.dart';
//import 'package:medcar_app/src/presentation/pages/client/historyTrip/ClientHistoryTripPage.dart';
import 'package:medcar_app/src/presentation/pages/company/home/bloc/CompanyHomeBloc.dart';
import 'package:medcar_app/src/presentation/pages/company/home/bloc/CompanyHomeEvent.dart';
import 'package:medcar_app/src/presentation/pages/company/home/bloc/CompanyHomeState.dart';
import 'package:medcar_app/src/presentation/pages/company/mapControl/CompanyMapControlPage.dart';
//
import 'package:medcar_app/src/presentation/pages/profile/info/ProfileInfoPage.dart';
import 'package:medcar_app/src/presentation/pages/roles/RolesPage.dart';

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({super.key});

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  List<Widget> pageList = <Widget>[
    CompanyMapControlPage(),
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
      body: BlocBuilder<CompanyHomeBloc, CompanyHomeState>(
        builder: (context, state) {
          return pageList[state.pageIndex];
        },
      ),
      drawer: BlocBuilder<CompanyHomeBloc, CompanyHomeState>(
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
                    'Menu de la Empresa',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text('Mapa de Seguimiento'),
                  selected: state.pageIndex == 0,
                  onTap: () {
                    context
                        .read<CompanyHomeBloc>()
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
                  title: Text('Perfil de la empresa'),
                  selected: state.pageIndex == 1,
                  onTap: () {
                    context
                        .read<CompanyHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 1));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Roles de usuario'),
                  selected: state.pageIndex == 2,
                  onTap: () {
                    context
                        .read<CompanyHomeBloc>()
                        .add(ChangeDrawerPage(pageIndex: 2));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Cerrar sesion'),
                  onTap: () {
                    // Despacha el evento de logout al Bloc.
                    context.read<CompanyHomeBloc>().add(Logout());
                    context.read<BlocSocketIO>().add(DisconnectSocketIO());

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
                        MaterialPageRoute(builder: (context) => MyApp()),
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
