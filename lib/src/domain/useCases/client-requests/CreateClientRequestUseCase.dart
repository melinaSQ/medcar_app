// ignore_for_file: file_names

import 'package:medcar_app/src/domain/models/ClientRequest.dart';
import 'package:medcar_app/src/domain/repository/ClientRequestsRepository.dart';

class CreateClientRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  CreateClientRequestUseCase(this.clientRequestsRepository);

  run(ClientRequest clientRequest) => clientRequestsRepository.create(clientRequest);


}