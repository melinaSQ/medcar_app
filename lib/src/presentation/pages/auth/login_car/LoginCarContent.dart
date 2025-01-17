// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcar_app/src/presentation/pages/auth/login_car/bloc/LoginCarBloc.dart';
import 'package:medcar_app/src/presentation/pages/auth/login_car/bloc/LoginCarEvent.dart';
import 'package:medcar_app/src/presentation/pages/auth/login_car/bloc/LoginCarState.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';
import 'package:medcar_app/src/presentation/widgets/DefaultButton.dart';
import 'package:medcar_app/src/presentation/widgets/DefaultTextField.dart';

// ignore: must_be_immutable
class LoginCarContent extends StatelessWidget {
  LoginCarState state;

  LoginCarContent(this.state);

  //const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: Stack(
        children: [
          //****1 container pantalla compelta opcions de login y registro
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  Color(0xFF652580), //morado kev
                  Color(0xFF5a469c), //morado
                  Color(0xFF00A099), //turquesa kev
                  //Color(0xFF40e0d0), //turquesa
                  //Color(0xFF937ccb), //morado
                  //Color(0xFF6041a2), //morado
                  //Color.fromARGB(255, 12, 38, 145),
                  //Color.fromARGB(255, 34, 156, 249),
                ],
              ),
            ),
            padding: EdgeInsets.only(left: 12),
          ),

          //**** 2 container del formulario de login

          SingleChildScrollView(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              // margin: EdgeInsets.only(left: 60, bottom: 35),
              padding: EdgeInsets.only(bottom: 35),
              margin:
                  EdgeInsets.only(left: 100, bottom: 200, right: 100, top: 200),
              // margin: EdgeInsets.all(100),
              decoration: BoxDecoration(
                //color: Colors.white,
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: const [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 154, 154, 154),
                    ]),
                borderRadius: BorderRadius.all(Radius.circular(35)),
              ),

              //******conteenido del fomrulario
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                // child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    _imageMedcar(),
                    _text('Estas ingresando como Conductor', 28),
                    _text('Introduce los datos de la ambulancia que manejaras',
                        18),

                    //***campo placa
                    DefaultTextField(
                        onChanged: (text) {
                          context.read<LoginCarBloc>().add(CarPlateChanged(
                              plate: BlocFormItem(value: text)));
                        },
                        validator: (value) {
                          return state.plate.error;
                        },
                        text: 'Número de Placa',
                        icon: Icons.car_rental),

                    //****campo code */
                    DefaultTextField(
                      onChanged: (text) {
                        context
                            .read<LoginCarBloc>()
                            .add(CodeChanged(code: BlocFormItem(value: text)));
                      },
                      validator: (value) {
                        return state.code.error;
                      },
                      obscureText: true,
                      text: 'Codigo de Verificación',
                      icon: Icons.lock_outlined,
                      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                    ),

                    SizedBox(
                      height: 40,
                    ),

                    //****boton de ingresar */
                    DefaultButton(
                      text: 'INGRESAR',
                      //color: Color(0xAA4b4949),
                      color: Color(0xFF6041a2),
                      textColor: Colors.white,

                      onPressed: () {
                        print('ingreso al onpress en logincarcontent');
                        // print('id user: ${state.userId}');
                        // print('Plate: ${state.plate.value}');
                        // print('Code: ${state.code.value}');

                        print(
                            'estado del form: ${state.formKey!.currentState!}');

                        if (state.formKey!.currentState!.validate()) {
                          context.read<LoginCarBloc>().add(FormSubmit());
                        } else {
                          print('El formulario no es valido');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          //aqui terminar el conteiner
        ],
      ),
    );
  }

  Widget _text(String text, double size) {
    return Container(
      alignment: Alignment.center, // Alinea el texto en el centro
      //margin: EdgeInsets.all(8.0), // Añade un margen de 20 puntos alrededor del texto
      padding: EdgeInsets.all(
          10.0), // Añade un padding de 10 puntos alrededor del texto
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: size,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _imageMedcar() {
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/medcar_logo_color.png',
        width: 400,
        height: 300,
      ),
    );
  }
}
