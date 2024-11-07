// ignore_for_file: file_names

import 'package:medcar_app/src/domain/models/DriverTripRequest.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';

abstract class DriverTripRequestsRepository {

  Future<Resource<bool>> create(DriverTripRequest driverTripRequest);
  Future<Resource<List<DriverTripRequest>>> getDriverTripOffersByClientRequest(int idClientRequest);

}