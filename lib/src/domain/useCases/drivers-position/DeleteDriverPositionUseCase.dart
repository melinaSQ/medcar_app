
// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/DriversPositionRepository.dart';

class DeleteDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  DeleteDriverPositionUseCase(this.driverPositionRepository);

  run(int idDriver) => driverPositionRepository.delete(idDriver);

}