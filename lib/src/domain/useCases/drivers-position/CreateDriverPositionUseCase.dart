
// ignore_for_file: file_names

import 'package:medcar_app/src/domain/models/DriverPosition.dart';
import 'package:medcar_app/src/domain/repository/DriversPositionRepository.dart';

class CreateDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  CreateDriverPositionUseCase(this.driverPositionRepository);

  run(DriverPosition driverPosition) => driverPositionRepository.create(driverPosition);

}