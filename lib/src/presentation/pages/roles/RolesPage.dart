// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcar_app/src/domain/models/Role.dart';
import 'package:medcar_app/src/presentation/pages/roles/RolesItem.dart';
import 'package:medcar_app/src/presentation/pages/roles/bloc/RolesBloc.dart';
import 'package:medcar_app/src/presentation/pages/roles/bloc/RolesState.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RolesBloc, RolesState>(
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: const [
                  Color(0xFF652580), //morado kev
                  Color(0xFF5a469c), //morado
                  Color(0xFF00A099), //turquesa kev
                ])),
            child: ListView(
              shrinkWrap: true,
              children: state.roles != null
                  ? (state.roles?.map((Role role) {
                      return RolesItem(role);
                    }).toList()) as List<Widget>
                  : [],
            ),
          );
        },
      ),
    );
  }
}
