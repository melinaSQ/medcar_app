// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors, sized_box_for_whitespace, avoid_print, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medcar_app/src/domain/models/ClientRequestResponse.dart';
import 'package:medcar_app/src/domain/models/DriverTripRequest.dart';
import 'package:medcar_app/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsBloc.dart';
import 'package:medcar_app/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsEvent.dart';
import 'package:medcar_app/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsState.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';
// import 'package:medcar_app/src/presentation/utils/GalleryOrPhotoDialog.dart';
import 'package:medcar_app/src/presentation/widgets/DefaultTextField.dart';

import 'package:intl/intl.dart';

class DriverClientRequestsItem extends StatelessWidget {
  DriverClientRequestsState state;
  ClientRequestResponse? clientRequest;

  DriverClientRequestsItem(this.state, this.clientRequest);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FareOfferedDialog(context, () {
          print('clientRequest: ${clientRequest}');
          print('id driver: ${state.idDriver}');
          print('fareofefered: ${state.fareOffered.value}');

          if (clientRequest != null &&
              state.idDriver != null &&
              context
                  .read<DriverClientRequestsBloc>()
                  .state
                  .fareOffered
                  .value
                  .isNotEmpty)
          //
          {
            context.read<DriverClientRequestsBloc>().add(
              //pasando un solicitud del conductor para el usuario
                  CreateDriverTripRequest(
                    driverTripRequest: DriverTripRequest(
                      idDriver: state.idDriver!,
                      idClientRequest: clientRequest!.id,
                      fareOffered: double.parse(context
                          .read<DriverClientRequestsBloc>()
                          .state
                          .fareOffered
                          .value),
                      time: clientRequest!.googleDistanceMatrix!.duration.value
                              .toDouble() /
                          60,
                      distance: clientRequest!
                              .googleDistanceMatrix!.distance.value
                              .toDouble() /
                          1000,
                    ),
                  ),
                );
          } else {
            Fluttertoast.showToast(
                msg: 'No se puede enviar la oferta',
                toastLength: Toast.LENGTH_LONG);
          }
        });
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              trailing: _imageUser(),
              title: Text(
                'Fecha y Hora de Recogida: ${DateFormat('dd/MM/yyyy hh:mm a').format(clientRequest?.pickupDate ?? DateTime.now())}',
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${clientRequest?.client.name} ${clientRequest?.client.lastname}',
                style: TextStyle(fontSize: 16, color: Colors.blue[900]),
              ),
            ),
            ListTile(
              title: Text(
                'Datos del viaje',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              subtitle: Column(
                children: [_textPickup(), _textDestination()],
              ),
            ),
            ListTile(
              title: Text(
                'Datos del Paciente',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              subtitle: Column(
                children: [_textData()],
              ),
            ),
            ListTile(
              title: Text(
                'Tiempo y Distancia',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              subtitle: Column(
                children: [_textMinutes(), _textDistance()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textMinutes() {
    return Row(
      children: [
        Container(
          width: 140,
          child: Text(
            'Tiempo de llegada: ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
            child:
                Text(clientRequest?.googleDistanceMatrix?.duration.text ?? '')),
      ],
    );
  }

  Widget _textDistance() {
    return Row(
      children: [
        Container(
          width: 140,
          child: Text(
            'Recorrido: ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
            child:
                Text(clientRequest?.googleDistanceMatrix?.distance.text ?? '')),
      ],
    );
  }

  Widget _textData() {
    return Row(
      children: [
        Container(
          width: 90,
          child: Text(
            'Diagnostico: ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(child: Text(clientRequest?.patientData ?? '')),
      ],
    );
  }

  Widget _textPickup() {
    return Row(
      children: [
        Container(
          width: 90,
          child: Text(
            'Recoger en: ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(child: Text(clientRequest?.pickupDescription ?? '')),
      ],
    );
  }

  Widget _textDestination() {
    return Row(
      children: [
        Container(
          width: 90,
          child: Text(
            'Llevar a: ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(child: Text(clientRequest?.destinationDescription ?? '')),
      ],
    );
  }

  Widget _imageUser() {
    return Container(
      width: 60,
      // margin: EdgeInsets.only(top: 25, bottom: 15),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipOval(
          child: clientRequest != null
              ? clientRequest!.client.image != null
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/img/user_image.png',
                      image: clientRequest!.client.image,
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(seconds: 1),
                    )
                  : Image.asset(
                      'assets/img/user_image.png',
                    )
              : Container(),
        ),
      ),
    );
  }

  FareOfferedDialog(BuildContext context, Function() submit) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Ingresa tu tarifa',
          style: TextStyle(fontSize: 17),
        ),
        contentPadding: EdgeInsets.only(bottom: 15),
        content: DefaultTextField(
            text: 'Valor',
            icon: Icons.attach_money,
            keyboardType: TextInputType.phone,
            onChanged: (text) {
              print('Tarifa del viaje: ${text}');
              context.read<DriverClientRequestsBloc>().add(
                  FareOfferedChange(fareOffered: BlocFormItem(value: text)));
            }),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                submit();
              },
              child: Text(
                'Enviar tarifa',
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}
