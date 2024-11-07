// ignore_for_file: file_names

import 'package:medcar_app/src/domain/useCases/driver-trip-request/CreateDriverTripRequestUseCase.dart';
import 'package:medcar_app/src/domain/useCases/driver-trip-request/GetDriverTripOffersByClientRequestUseCase.dart';

class DriverTripRequestUseCases {

  CreateDriverTripRequestUseCase createDriverTripRequest;
  GetDriverTripOffersByClientRequestUseCase getDriverTripOffersByClientRequest;

  DriverTripRequestUseCases({
    required this.createDriverTripRequest,
    required this.getDriverTripOffersByClientRequest,
  });

}