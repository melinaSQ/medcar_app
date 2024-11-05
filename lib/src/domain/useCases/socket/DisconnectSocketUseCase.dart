// ignore_for_file: file_names

import 'package:medcar_app/src/domain/repository/SocketRepository.dart';

class DisconnectSocketUseCase {

  SocketRepository socketRepository;

  DisconnectSocketUseCase(this.socketRepository);

  run() => socketRepository.disconnect();

}