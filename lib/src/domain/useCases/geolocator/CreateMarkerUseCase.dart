// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/GeolocatorRepository.dart';

class CreateMarkerUseCase {

  GeolocatorRepository geolocatorRepository;
  CreateMarkerUseCase(this.geolocatorRepository);
  run(String path) => geolocatorRepository.createMarkerFromAsset(path);
}