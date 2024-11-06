// ignore_for_file: file_names

import 'package:medcar_app/src/domain/models/DriverPosition.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';

abstract class DriverPositionRepository {

  Future<Resource<bool>> create(DriverPosition driverPosition);
  Future<Resource<bool>> delete(int idDriver);
  // Future<Resource<DriverPosition>> getDriverPosition(int idDriver);

}