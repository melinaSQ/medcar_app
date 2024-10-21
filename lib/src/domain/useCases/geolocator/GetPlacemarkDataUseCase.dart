// ignore_for_file: file_names

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medcar_app/src/domain/repository/GeolocatorRepository.dart';

class GetPlacemarkDataUseCase {

  GeolocatorRepository geolocatorRepository;

  GetPlacemarkDataUseCase(this.geolocatorRepository);

  run(CameraPosition cameraPosition) => geolocatorRepository.getPlacemarkData(cameraPosition);

}