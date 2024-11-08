// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/ClientRequestsRepository.dart';

class UpdateDriverAssignedUseCase {

  ClientRequestsRepository clientRequestsRepository;

  UpdateDriverAssignedUseCase(this.clientRequestsRepository);

  run(int idClientRequest, int idDriver, double fareAssigned) => clientRequestsRepository.updateDriverAssigned(idClientRequest, idDriver, fareAssigned);

}