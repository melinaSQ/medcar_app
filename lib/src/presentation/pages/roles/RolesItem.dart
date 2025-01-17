// ignore_for_file: must_be_immutable, file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:medcar_app/src/domain/models/Role.dart';

class RolesItem extends StatelessWidget {
  Role role;

  RolesItem(this.role);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (role.name == 'DRIVER' && role.name == 'DRIVER') {
          Navigator.pushNamedAndRemoveUntil(
              context, 'driver/form', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, role.route, (route) => false);
        }
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 15),
            height: 150,
            child: FadeInImage(
              image: NetworkImage(role.image),
              fit: BoxFit.contain,
              fadeInDuration: Duration(seconds: 1),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ),
          Text(
            role.name,
            style: TextStyle(
                fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }
}
