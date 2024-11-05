// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/SocketRepository.dart';

class ConnectSocketUseCase {

  SocketRepository socketRepository;

  ConnectSocketUseCase(this.socketRepository);

  run() => socketRepository.connect();

}