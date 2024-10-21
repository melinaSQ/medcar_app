import 'package:medcar_app/src/domain/repository/GeolocatorRepository.dart';

class FindPositionUseCase {

  GeolocatorRepository geolocatorRepository;

  FindPositionUseCase(this.geolocatorRepository);

  run() => geolocatorRepository.findPosition();

}