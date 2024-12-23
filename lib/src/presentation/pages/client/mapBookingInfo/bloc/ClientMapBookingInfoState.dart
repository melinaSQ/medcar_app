// ignore_for_file: file_names, unnecessary_this

import 'dart:async';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:medcar_app/src/domain/models/PlacemarkData.dart';
// import 'package:medcar_app/src/domain/models/TimeAndDistanceValues.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';

class ClientMapBookingInfoState extends Equatable {
  final Completer<GoogleMapController>? controller;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  final Position? position;
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;
  final Resource? responseTimeAndDistance;
  final Resource? responseClientRequest;
  //extras
  final BlocFormItem patientData;
  final BlocFormItem pickupDate;

  const ClientMapBookingInfoState({
    this.position,
    this.controller,
    this.cameraPosition = const CameraPosition(
        target: LatLng(4.7449125, -74.1113708), zoom: 14.0),
    this.pickUpLatLng,
    this.destinationLatLng,
    this.pickUpDescription = '',
    this.destinationDescription = '',
    this.markers = const <MarkerId, Marker>{},
    this.polylines = const <PolylineId, Polyline>{},
    this.responseTimeAndDistance,
    this.responseClientRequest,
    //
    this.patientData = const BlocFormItem(error: 'Ingresa los datos del paciente'),
    this.pickupDate = const BlocFormItem(error: 'Ingresa la fecha y hora de recogida'),

  });

  ClientMapBookingInfoState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    LatLng? pickUpLatLng,
    LatLng? destinationLatLng,
    String? pickUpDescription,
    String? destinationDescription,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    Resource? responseTimeAndDistance,
    Resource? responseClientRequest,
    BlocFormItem? fareOffered,
    //
    BlocFormItem? patientData,
    BlocFormItem? pickupDate, 
  }) {
    return ClientMapBookingInfoState(
      position: position ?? this.position,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpDescription:
          pickUpDescription ?? this.pickUpDescription, // Manejo del valor nulo
      destinationDescription:
          destinationDescription ?? this.destinationDescription,
      responseTimeAndDistance:
          responseTimeAndDistance ?? this.responseTimeAndDistance,
      responseClientRequest: responseClientRequest,
      patientData: patientData ?? this.patientData,
      pickupDate: pickupDate ?? this.pickupDate,
    );
  }

  @override
  List<Object?> get props => [
        position,
        markers,
        polylines,
        controller,
        cameraPosition,
        pickUpLatLng,
        destinationLatLng,
        pickUpDescription,
        destinationDescription,
        responseTimeAndDistance,
        responseClientRequest,
        //
        patientData,
        pickupDate,
      ];
  
}
