// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:medcar_app/blocSocketIO/BlocSocketIO.dart';
// import 'package:medcar_app/blocSocketIO/BlocSocketIOEvent.dart';
//
import 'package:medcar_app/src/presentation/pages/company/mapControl/bloc/CompanyMapControlBloc.dart';
import 'package:medcar_app/src/presentation/pages/company/mapControl/bloc/CompanyMapControlEvent.dart';
import 'package:medcar_app/src/presentation/pages/company/mapControl/bloc/CompanyMapControlState.dart';

//
import 'package:medcar_app/src/presentation/widgets/DefaultButton.dart';
// import 'package:toggle_switch/toggle_switch.dart';

class CompanyMapControlPage extends StatefulWidget {
  const CompanyMapControlPage({super.key});

  @override
  State<CompanyMapControlPage> createState() => _CompanyMapControlPageState();
}

class _CompanyMapControlPageState extends State<CompanyMapControlPage> {
  BitmapDescriptor? customIcon;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CompanyMapControlBloc>().add(CompanyMapControlInitEvent());
      context
          .read<CompanyMapControlBloc>()
          .add(ListenDriversPositionSocketIO());
      context
          .read<CompanyMapControlBloc>()
          .add(ListenDriversDisconnectedSocketIO());
      context.read<CompanyMapControlBloc>().add(FindPosition());
    });
  }

  void _goToMyLocation() {
    context.read<CompanyMapControlBloc>().add(FindPosition());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CompanyMapControlBloc, CompanyMapControlState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              _googleMaps(state),
              // _iconMyLocation(),
              _myLocationButton(),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: DefaultButton(
                    margin: EdgeInsets.only(bottom: 30, left: 60, right: 60),
                    text: 'REVISAR VIAJE',
                    iconData: Icons.check_circle,
                    // textColor: Colors.white,
                    onPressed: () {},
                  ))
            ],
          );
        },
      ),
    );
  }

  GoogleMap _googleMaps(CompanyMapControlState state) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: state.cameraPosition,
      markers: Set<Marker>.of(state.markers.values),

      // Marcador personalizado en la posición actual
      //   {Marker(
      //     markerId: MarkerId('currentLocation'),
      //     // position: state.currentLocation ?? state.cameraPosition.target,
      //     icon: customIcon ??
      //         BitmapDescriptor
      //             .defaultMarker, // Usa el icono predeterminado si el personalizado no está listo,
      //   ),
      // },
      myLocationEnabled: true,
      myLocationButtonEnabled: false, // Desactiva el botón predeterminado
      
      onMapCreated: (GoogleMapController controller) {
        if (!state.controller!.isCompleted) {
          state.controller?.complete(controller);
        }
      },
      style:
          '[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]',
    );
  }

  Widget _iconMyLocation() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/medical_pin3.png',
        width: 50,
        height: 50,
      ),
    );
  }

  // Botón para centrar en la ubicación actual
  Widget _myLocationButton() {
    return Positioned(
      bottom: 120,
      right: 10,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _goToMyLocation,
        child: Icon(
          Icons.my_location,
          color: Colors.blue,
        ),
      ),
    );
  }
}
