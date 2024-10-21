// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:medcar_app/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerBloc.dart';
import 'package:medcar_app/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerEvent.dart';
import 'package:medcar_app/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerState.dart';
// import 'package:medcar_app/src/presentation/widgets/DefaultActionText.dart';
import 'package:medcar_app/src/presentation/widgets/DefaultButton.dart';
import 'package:medcar_app/src/presentation/widgets/GooglePlacesAutoComplete.dart';

class ClientMapSeekerPage extends StatefulWidget {
  const ClientMapSeekerPage({super.key});

  @override
  State<ClientMapSeekerPage> createState() => _ClientMapSeekerPageState();
}

class _ClientMapSeekerPageState extends State<ClientMapSeekerPage> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientMapSeekerBloc>().add(ClientMapSeekerInitEvent());
      // context.read<ClientMapSeekerBloc>().add(ListenDriversPositionSocketIO());
      // context.read<ClientMapSeekerBloc>().add(ListenDriversDisconnectedSocketIO());
      context.read<ClientMapSeekerBloc>().add(FindPosition());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientMapSeekerBloc, ClientMapSeekerState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: state.cameraPosition,

                markers: Set<Marker>.of(state.markers.values),
                onCameraMove: (CameraPosition cameraPosition) {
                  context
                      .read<ClientMapSeekerBloc>()
                      .add(OnCameraMove(cameraPosition: cameraPosition));
                },

                onCameraIdle: () async {
                  context.read<ClientMapSeekerBloc>().add(OnCameraIdle());
                  pickUpController.text = state.placemarkData?.address ?? '';
                  // if (state.placemarkData != null) {
                  //   context.read<ClientMapSeekerBloc>().add(
                  //       OnAutoCompletedPickUpSelected(
                  //           lat: state.placemarkData!.lat,
                  //           lng: state.placemarkData!.lng,
                  //           pickUpDescription: state.placemarkData!.address));
                  // }
                },

                onMapCreated: (GoogleMapController controller) {
                  if (state.controller != null) {
                    if (!state.controller!.isCompleted) {
                      state.controller?.complete(controller);
                    }
                  }
                },
                style:
                    '[ { "elementType": "geometry", "stylers": [ { "color": "#ebe3cd" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#523735" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#f5f1e6" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#c9b2a6" } ] }, { "featureType": "administrative.land_parcel", "elementType": "geometry.stroke", "stylers": [ { "color": "#dcd2be" } ] }, { "featureType": "administrative.land_parcel", "elementType": "labels.text.fill", "stylers": [ { "color": "#ae9e90" } ] }, { "featureType": "landscape.natural", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#93817c" } ] }, { "featureType": "poi.park", "elementType": "geometry.fill", "stylers": [ { "color": "#a5b076" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#447530" } ] }, { "featureType": "road", "elementType": "geometry", "stylers": [ { "color": "#f5f1e6" } ] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [ { "color": "#fdfcf8" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#f8c967" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#e9bc62" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry", "stylers": [ { "color": "#e98d58" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry.stroke", "stylers": [ { "color": "#db8555" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#806b63" } ] }, { "featureType": "transit.line", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "transit.line", "elementType": "labels.text.fill", "stylers": [ { "color": "#8f7d77" } ] }, { "featureType": "transit.line", "elementType": "labels.text.stroke", "stylers": [ { "color": "#ebe3cd" } ] }, { "featureType": "transit.station", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "water", "elementType": "geometry.fill", "stylers": [ { "color": "#b9d3c2" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#92998d" } ] } ]', // Aplica el estilo directamente aquí
                // Otras propiedades del GoogleMap

                // onMapCreated: (GoogleMapController controller)
                // {
                //   controller.setMapStyle('[ { "elementType": "geometry", "stylers": [ { "color": "#ebe3cd" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#523735" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#f5f1e6" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#c9b2a6" } ] }, { "featureType": "administrative.land_parcel", "elementType": "geometry.stroke", "stylers": [ { "color": "#dcd2be" } ] }, { "featureType": "administrative.land_parcel", "elementType": "labels.text.fill", "stylers": [ { "color": "#ae9e90" } ] }, { "featureType": "landscape.natural", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#93817c" } ] }, { "featureType": "poi.park", "elementType": "geometry.fill", "stylers": [ { "color": "#a5b076" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#447530" } ] }, { "featureType": "road", "elementType": "geometry", "stylers": [ { "color": "#f5f1e6" } ] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [ { "color": "#fdfcf8" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#f8c967" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#e9bc62" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry", "stylers": [ { "color": "#e98d58" } ] }, { "featureType": "road.highway.controlled_access", "elementType": "geometry.stroke", "stylers": [ { "color": "#db8555" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#806b63" } ] }, { "featureType": "transit.line", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "transit.line", "elementType": "labels.text.fill", "stylers": [ { "color": "#8f7d77" } ] }, { "featureType": "transit.line", "elementType": "labels.text.stroke", "stylers": [ { "color": "#ebe3cd" } ] }, { "featureType": "transit.station", "elementType": "geometry", "stylers": [ { "color": "#dfd2ae" } ] }, { "featureType": "water", "elementType": "geometry.fill", "stylers": [ { "color": "#b9d3c2" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#92998d" } ] } ]');
                //   if (state.controller != null) {
                //     if (!state.controller!.isCompleted) {
                //       state.controller?.complete(controller);
                //     }
                //   }
                // },
              ),
              Container(
                  height: 120,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: _googlePlacesAutocomplete()),
              _iconMyLocation(),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: DefaultButton(
                    margin: EdgeInsets.only(bottom: 30, left: 60, right: 60),
                    text: 'REVISAR VIAJE',
                    iconData: Icons.check_circle,
                    // textColor: Colors.white,
                    onPressed: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   'client/map/booking',
                      //   arguments: {
                      //     'pickUpLatLng': state.pickUpLatLng,
                      //     'destinationLatLng': state.destinationLatLng,
                      //     'pickUpDescription': state.pickUpDescription,
                      //     'destinationDescription':
                      //         state.destinationDescription,
                      //   },
                      // );
                    },
                  ))
            ],
          );
        },
      ),
    );
  }

  Widget _googlePlacesAutocomplete() {
    return Card(
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          GooglePlacesAutoComplete(pickUpController, 'Recoger en',
              (Prediction prediction) {
            // ignore: unnecessary_null_comparison
            if (prediction != null) {
              context.read<ClientMapSeekerBloc>().add(
                    ChangeMapCameraPosition(
                      lat: double.parse(prediction.lat!),
                      lng: double.parse(prediction.lng!),
                    ),
                  );
              // context.read<ClientMapSeekerBloc>().add(
              //     OnAutoCompletedPickUpSelected(
              //         lat: double.parse(prediction.lat!),
              //         lng: double.parse(prediction.lng!),
              //         pickUpDescription: prediction.description ?? ''));
            }
          }),
          Divider(
            color: Colors.grey[200],
          ),
          GooglePlacesAutoComplete(destinationController, 'Dejar en',
              (Prediction prediction) {
            // context.read<ClientMapSeekerBloc>().add(
            //     OnAutoCompletedDestinationSelected(
            //         lat: double.parse(prediction.lat!),
            //         lng: double.parse(prediction.lng!),
            //         destinationDescription: prediction.description ?? ''));
          })
        ],
      ),
    );
  }

  Widget _iconMyLocation() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/location_blue.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
