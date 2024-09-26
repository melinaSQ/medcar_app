import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultTextFieldOutlined extends StatelessWidget {
  String text;
  Function(String text) onChanged;
  IconData icon;
  EdgeInsetsGeometry margin;
  String? Function(String?)? validator;

  DefaultTextFieldOutlined(
      {super.key,
      required this.text,
      required this.icon,
      required this.onChanged,
      this.margin = const EdgeInsets.only(top: 50, left: 20, right: 20),
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: margin,
      decoration: BoxDecoration(
          // color: Color.fromRGBO(255, 255, 255, 0.2),
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(15),
          //   bottomRight: Radius.circular(15),
          // )
          ),
      child: TextFormField(
        onChanged: (text) {
          onChanged(text);
        },
        style: TextStyle(fontSize: 20),
        validator: validator,
        decoration: InputDecoration(
            label: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),

            // border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 35, 161, 183), width: 2)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 34, 101, 202), width: 2)),
            prefixIcon: Container(
              //margin: EdgeInsets.only(top: 10),
              margin: EdgeInsets.all(15),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 32,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 2, left: 15),
                    height: 35,
                    width: 1,
                    color: Colors.white,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
