// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class DefaultIconBack extends StatelessWidget {

  Color color;
  EdgeInsetsGeometry? margin;

  // ignore: use_key_in_widget_constructors
  DefaultIconBack({
    this.color = Colors.white,
    this.margin
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: margin,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        }, 
        icon: Icon(
          Icons.arrow_back_ios,
          size: 35,
          color: color,
        )
      ),
    );
  }
}