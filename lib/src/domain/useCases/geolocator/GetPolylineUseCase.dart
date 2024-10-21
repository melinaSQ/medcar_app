// ignore_for_file: file_names

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medcar_app/src/domain/repository/GeolocatorRepository.dart';

class GetPolylineUseCase {

  GeolocatorRepository geolocatorRepository;

  GetPolylineUseCase(this.geolocatorRepository);

  run(LatLng pickUpLatLng, LatLng destinationLatLng) => geolocatorRepository.getPolyline(pickUpLatLng, destinationLatLng);
}