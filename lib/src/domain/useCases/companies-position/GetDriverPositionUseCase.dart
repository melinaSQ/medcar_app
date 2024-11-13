
// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/DriversPositionRepository.dart';

class GetDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  GetDriverPositionUseCase(this.driverPositionRepository);

  run(int idDriver) => driverPositionRepository.getDriverPosition(idDriver);
 
}