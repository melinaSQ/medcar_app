// ignore_for_file: file_names

import 'dart:async';
import 'package:image/image.dart' as img;

//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:medcar_app/blocSocketIO/BlocSocketIO.dart';
import 'package:medcar_app/src/domain/models/AuthResponse.dart';
import 'package:medcar_app/src/domain/models/ClientRequest.dart';
import 'package:medcar_app/src/domain/models/TimeAndDistanceValues.dart';
import 'package:medcar_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:medcar_app/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:medcar_app/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';
import 'package:medcar_app/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoEvent.dart';
import 'package:medcar_app/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoState.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';

class ClientMapBookingInfoBloc
    extends Bloc<ClientMapBookingInfoEvent, ClientMapBookingInfoState> {
  GeolocatorUseCases geolocatorUseCases;
  ClientRequestsUseCases clientRequestsUseCases;
  AuthUseCases authUseCases;
  // BlocSocketIO blocSocketIO;

  // ClientMapBookingInfoBloc(this.blocSocketIO, this.geolocatorUseCases, this.clientRequestsUseCases, this.authUseCases): super(ClientMapBookingInfoState()) {

  ClientMapBookingInfoBloc(
      this.geolocatorUseCases, this.clientRequestsUseCases, this.authUseCases)
      : super(ClientMapBookingInfoState()) {
    //init event
    on<ClientMapBookingInfoInitEvent>((event, emit) async {
      Completer<GoogleMapController> controller =
          Completer<GoogleMapController>();
      emit(state.copyWith(
        pickUpLatLng: event.pickUpLatLng,
        destinationLatLng: event.destinationLatLng,
        pickUpDescription: event.pickUpDescription,
        destinationDescription: event.destinationDescription,
        controller: controller,
      ));

      //
      // Redimensionar imagen
      Future<BitmapDescriptor> getResizedBitmapDescriptor(
          String assetPath, int width, int height) async {
        // Cargar la imagen
        ByteData data = await rootBundle.load(assetPath);
        Uint8List bytes = data.buffer.asUint8List();

        // Decodificar y redimensionar la imagen
        img.Image originalImage = img.decodeImage(bytes)!;
        img.Image resizedImage =
            img.copyResize(originalImage, width: width, height: height);

        // Codificar la imagen redimensionada
        Uint8List resizedBytes =
            Uint8List.fromList(img.encodePng(resizedImage));

        // ignore: deprecated_member_use
        return BitmapDescriptor.fromBytes(resizedBytes);
      }

      // Crea los marcadores usando las imágenes redimensionadas
      BitmapDescriptor pickUpDescriptor = await getResizedBitmapDescriptor(
          'assets/img/pin_white.png', 64, 64); // Cambia el tamaño a 64x64
      BitmapDescriptor destinationDescriptor = await getResizedBitmapDescriptor(
          'assets/img/flag.png', 64, 64); // Cambia el tamaño a 64x64

      // BitmapDescriptor pickUpDescriptor =
      //     await geolocatorUseCases.createMarker.run('assets/img/pin_white.png');
      // BitmapDescriptor destinationDescriptor =
      //     await geolocatorUseCases.createMarker.run('assets/img/flag.png');
      Marker markerPickUp = geolocatorUseCases.getMarker.run(
          'pickup',
          state.pickUpLatLng!.latitude,
          state.pickUpLatLng!.longitude,
          'Lugar de recogida',
          'Debes permancer aqui mientras llega el conductor',
          pickUpDescriptor);
      Marker markerDestination = geolocatorUseCases.getMarker.run(
          'destination',
          state.destinationLatLng!.latitude,
          state.destinationLatLng!.longitude,
          'Tu Destino',
          '',
          destinationDescriptor);
      emit(state.copyWith(
        markers: {
          markerPickUp.markerId: markerPickUp,
          markerDestination.markerId: markerDestination
        },
      ));
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      GoogleMapController googleMapController = await state.controller!.future;
      await googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(event.lat, event.lng),
          zoom: 12,
          bearing: 0,
        )),
      );
    });

    on<FareOfferedChanged>((event, emit) {
      emit(state.copyWith(
        fareOffered: BlocFormItem(
            value: event.fareOffered.value,
            error:
                event.fareOffered.value.isEmpty ? 'Ingresa la tarifa' : null),
      ));
    });

    on<CreateClientRequest>((event, emit) async {
      AuthResponse authResponse = await authUseCases.getUserSession.run();

      // Resource<bool> response = await clientRequestsUseCases.createClientRequest
      Resource<int> response = await clientRequestsUseCases.createClientRequest
          .run(ClientRequest(
              idClient: authResponse.user.id!,
              fareOffered: double.parse(state.fareOffered.value),
              pickupDescription: state.pickUpDescription,
              destinationDescription: state.destinationDescription,
              pickupLat: state.pickUpLatLng!.latitude,
              pickupLng: state.pickUpLatLng!.longitude,
              destinationLat: state.destinationLatLng!.latitude,
              destinationLng: state.destinationLatLng!.longitude));

      emit(state.copyWith(responseClientRequest: response));
    });

    // on<EmitNewClientRequestSocketIO>((event, emit) {
    //   if (blocSocketIO.state.socket != null) {
    //     blocSocketIO.state.socket?.emit(
    //         'new_client_request', {'id_client_request': event.idClientRequest});
    //   }
    // });

    on<GetTimeAndDistanceValues>((event, emit) async {
      emit(state.copyWith(responseTimeAndDistance: Loading()));
      Resource<TimeAndDistanceValues> response =
          await clientRequestsUseCases.getTimeAndDistance.run(
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
      );
      emit(state.copyWith(responseTimeAndDistance: response));
    });

    on<AddPolyline>((event, emit) async {
      List<LatLng> polylineCoordinates = await geolocatorUseCases.getPolyline
          .run(state.pickUpLatLng!, state.destinationLatLng!);
      PolylineId id = PolylineId("MyRoute");
      Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blueAccent,
          points: polylineCoordinates,
          width: 6);
      emit(state.copyWith(polylines: {id: polyline}));
    });
  }
}
