// ignore_for_file: file_names

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medcar_app/src/domain/models/PlacemarkData.dart';
// import 'package:socket_io_client/socket_io_client.dart';

class CompanyMapControlState extends Equatable {
  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final PlacemarkData? placemarkData;
  final Map<MarkerId, Marker> markers;
  final LatLng? pickUpLatLng;
  final LatLng? destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;
  //
  final int? idCompany;

  const CompanyMapControlState({
    this.position,
    this.controller,
    this.cameraPosition = const CameraPosition(
        target: LatLng(-17.3927522, -66.1592157), zoom: 17.0),
    this.placemarkData,
    this.pickUpLatLng,
    this.destinationLatLng,
    this.pickUpDescription = '',
    this.destinationDescription = '',
    this.markers = const <MarkerId, Marker>{},
    this.idCompany,
  });

  CompanyMapControlState copyWith(
      {Position? position,
      Completer<GoogleMapController>? controller,
      CameraPosition? cameraPosition,
      PlacemarkData? placemarkData,
      LatLng? pickUpLatLng,
      LatLng? destinationLatLng,
      String? pickUpDescription,
      String? destinationDescription,
      Map<MarkerId, Marker>? markers,
      int? idCompany}) {
    return CompanyMapControlState(
      position: position ?? this.position,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      placemarkData: placemarkData ?? this.placemarkData,
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpDescription: pickUpDescription ?? this.pickUpDescription,
      destinationDescription:
          destinationDescription ?? this.destinationDescription,
      idCompany: idCompany ?? this.idCompany,
    );
  }

  @override
  List<Object?> get props => [
        position,
        markers,
        controller,
        cameraPosition,
        placemarkData,
        pickUpLatLng,
        destinationLatLng,
        pickUpDescription,
        destinationDescription,
        idCompany
      ];
}
