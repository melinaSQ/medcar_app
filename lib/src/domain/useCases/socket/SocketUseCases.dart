// ignore_for_file: file_names

import 'package:medcar_app/src/domain/useCases/socket/ConnectSocketUseCase.dart';
import 'package:medcar_app/src/domain/useCases/socket/DisconnectSocketUseCase.dart';

class SocketUseCases {

  ConnectSocketUseCase connect;
  DisconnectSocketUseCase disconnect;

  SocketUseCases({
    required this.connect,
    required this.disconnect
  });

}