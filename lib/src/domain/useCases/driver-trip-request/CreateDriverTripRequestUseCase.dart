// ignore_for_file: file_names

import 'package:medcar_app/src/domain/models/DriverTripRequest.dart';
import 'package:medcar_app/src/domain/repository/DriverTripRequestsRepository.dart';

class CreateDriverTripRequestUseCase {

  DriverTripRequestsRepository driverTripRequestsRepository;

  CreateDriverTripRequestUseCase(this.driverTripRequestsRepository);

  run(DriverTripRequest driverTripRequest) => driverTripRequestsRepository.create(driverTripRequest);
}