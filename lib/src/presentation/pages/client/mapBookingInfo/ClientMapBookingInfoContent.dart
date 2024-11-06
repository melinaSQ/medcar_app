// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medcar_app/src/domain/models/TimeAndDistanceValues.dart';
import 'package:medcar_app/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoBloc.dart';
import 'package:medcar_app/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoEvent.dart';
import 'package:medcar_app/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoState.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';
import 'package:medcar_app/src/presentation/widgets/DefaultIconBack.dart';
import 'package:medcar_app/src/presentation/widgets/DefaultTextField.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'; // Importar el paquete

class ClientMapBookingInfoContent extends StatelessWidget {
  ClientMapBookingInfoState state;
  TimeAndDistanceValues timeAndDistanceValues;

  ClientMapBookingInfoContent(this.state, this.timeAndDistanceValues);
  // ClientMapBookingInfoContent(this.state, TimeAndDistanceValues timeAndDistanceValues);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context),
        Align(
            alignment: Alignment.bottomCenter,
            child: _cardBookingInfo(context)),
        Container(
            margin: EdgeInsets.only(top: 50, left: 20),
            child: DefaultIconBack())
      ],
    );
  }

  Widget _cardBookingInfo(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.59,
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: const [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 186, 186, 186),
                ]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Recoger en',
                  style: TextStyle(fontSize: 15),
                ),
                subtitle: Text(
                  state.pickUpDescription,
                  style: TextStyle(fontSize: 13),
                ),
                leading: Icon(Icons.location_on),
              ),
              ListTile(
                title: Text(
                  'Dejar en',
                  style: TextStyle(fontSize: 15),
                ),
                subtitle: Text(
                  state.destinationDescription,
                  style: TextStyle(fontSize: 13),
                ),
                leading: Icon(Icons.my_location),
              ),
              ListTile(
                title: Text(
                  'Tiempo y distancia aproximados',
                  style: TextStyle(fontSize: 15),
                ),
                subtitle: Text(
                  '${timeAndDistanceValues.distance.text} y ${timeAndDistanceValues.duration.text}',
                  style: TextStyle(fontSize: 13),
                ),
                leading: Icon(Icons.timer),
              ),
              ListTile(
                title: Text(
                  'Precios recomendados',
                  style: TextStyle(fontSize: 15),
                ),
                subtitle: Text(
                  'Bs ${timeAndDistanceValues.recommendedValue}',
                  style: TextStyle(fontSize: 13),
                ),
                leading: Icon(Icons.money),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                iconAlignment: IconAlignment.start,
                onPressed: () => _selectDateTime(context),
                child: Text('Seleccionar Fecha y Hora'),
              ),
              DefaultTextField(
                margin: EdgeInsets.only(left: 15, right: 15),
                // text: 'Fecha y Hora de recogida',
                text: state.pickupDate.value,
                icon: Icons.schedule,
                keyboardType: TextInputType.none,
                onChanged: (text) {
                  context.read<ClientMapBookingInfoBloc>().add(
                      PickUpTimeChanged(pickupDate: BlocFormItem(value: text)));
                },
                validator: (value) {
                  return state.pickupDate.error;
                },
              ),
              SizedBox(
                height: 10,
              ),
              DefaultTextField(
                margin: EdgeInsets.only(left: 15, right: 15),
                text: 'Datos del paciente',
                icon: Icons.person,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  // context.read<ClientMapBookingInfoBloc>().add(FareOfferedChanged(fareOffered: BlocFormItem(value: text)));
                  context.read<ClientMapBookingInfoBloc>().add(
                      PatientDataChanged(
                          patientData: BlocFormItem(value: text)));
                },
                validator: (value) {
                  return state.patientData.error;
                },
              ),
              SizedBox(
                height: 10,
              ),
              _actionProfile('BUSCAR AMBULANCIA', Icons.search, () {
                context
                    .read<ClientMapBookingInfoBloc>()
                    .add(CreateClientRequest());
                print("boton  presionado");
              }),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  // Método para seleccionar fecha y hora
  // void _selectDateTime1(BuildContext context) {
  //   DatePicker.showDateTimePicker(
  //     context,
  //     showTitleActions: true,
  //     onConfirm: (date) {
  //       // Actualizar la variable con la fecha seleccionada
  //     //   setState(() {
  //     //     _selectedDateTime = "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
  //     //   });
  //     // },
  //     currentTime: DateTime.now(),
  //     locale: LocaleType.es,
  //   );
  // }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    // Seleccionar fecha
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
    }

    // Seleccionar hora
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime = pickedTime;
    }

    // Formatear la fecha en formato 'yyyy-MM-dd'
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    // Formatear la hora en formato de 24 horas (HH:mm)
    String formattedTime =
        "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";

    // Combina la fecha y la hora en un solo string
    String formattedDateTime = "$formattedDate $formattedTime";

    // Aquí, no es necesario convertirlo de nuevo a DateTime.parse() si no lo necesitas como un DateTime.
    // Si lo necesitas, entonces usa el formato adecuado para que el parseo funcione:
    // DateTime parsedDateTime = DateTime.parse(formattedDateTime);  // Usamos el formato 'yyyy-MM-dd HH:mm'

    // Actualizar el campo de texto con la fecha y hora seleccionada
    print("Fecha y hora seleccionada: $formattedDateTime");
    context.read<ClientMapBookingInfoBloc>().add(
        PickUpTimeChanged(pickupDate: BlocFormItem(value: formattedDateTime)));
  }

  Widget _actionProfile(String option, IconData icon, Function() function) {
    return GestureDetector(
      onTap: () {
        function();
        print("entro a la funcion");
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 0, top: 15),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            option,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: const [
                      Color.fromARGB(255, 19, 58, 213),
                      Color.fromARGB(255, 65, 173, 255),
                    ]),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _googleMaps(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height * 0.53,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPosition,
        markers: Set<Marker>.of(state.markers.values),
        polylines: Set<Polyline>.of(state.polylines.values),

        // onMapCreated: (GoogleMapController controller) {
        //   controller.setMapStyle('[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
        //   if (!state.controller!.isCompleted) {
        //     state.controller?.complete(controller);
        //   }
        // },
        onMapCreated: (GoogleMapController controller) {
          if (state.controller != null) {
            if (!state.controller!.isCompleted) {
              state.controller?.complete(controller);
            }
          }
        },
        // style:
        //     '[ { "elementType": "geometry", "stylers": [ { "color": "#ebe3cd" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#523735" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#f5f1e6" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#c9b2a6" } ] }, { "featureType": "administrative.land_parcel", "elementType": "geometry.stroke", "stylers": [ { "color": "#dcd2be" } ] }, { "featureType": "administrative.land_parcel", "elementType": "labels.text.fill", "stylers": [ { "color": "#ae9e90" } ] }, { "featureType": "landscape.natural", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#93817c" } ] }, { "featureType": "poi.park", "elementType": "geometry.fill", "stylers": [ { "color": "#a5b076" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#447530" } ] }, { "featureType": "road", "elementType": "geometry", "stylers": [ { "color": "#f5f1e6" } ] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [ { "color": "#fdfcf8" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#f8c967" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#e9bc62" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry", "stylers": [ { "color": "#e98d58" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry.stroke", "stylers": [ { "color": "#db8555" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#806b63" } ] }, { "featureType": "transit.line", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "transit.line", "elementType": "labels.text.fill", "stylers": [ { "color": "#8f7d77" } ] }, { "featureType": "transit.line", "elementType": "labels.text.stroke", "stylers": [ { "color": "#ebe3cd" } ] }, { "featureType": "transit.station", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "water", "elementType": "geometry.fill", "stylers": [ { "color": "#b9d3c2" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#92998d" } ] } ]', // Aplica el estilo directamente aquí
        style:
            '[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]',
      ),
    );
  }
}
