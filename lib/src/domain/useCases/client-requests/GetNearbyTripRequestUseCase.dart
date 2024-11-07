// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/ClientRequestsRepository.dart';

class GetNearbyTripRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetNearbyTripRequestUseCase(this.clientRequestsRepository);

  run(double driverLat, double driverLng) => clientRequestsRepository.getNearbyTripRequest(driverLat, driverLng);

}