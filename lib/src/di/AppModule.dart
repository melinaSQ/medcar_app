// ignore_for_file: file_names
import 'package:medcar_app/src/data/api/ApiConfig.dart';
import 'package:medcar_app/src/data/dataSource/local/SharefPref.dart';
import 'package:medcar_app/src/data/dataSource/remote/services/AuthService.dart';
import 'package:medcar_app/src/data/dataSource/remote/services/ClientRequestsService.dart';
// import 'package:medcar_app/src/data/dataSource/remote/services/DriverCarInfoService.dart';
import 'package:medcar_app/src/data/dataSource/remote/services/DriverTripRequestsService.dart';
import 'package:medcar_app/src/data/dataSource/remote/services/DriversPositionService.dart';
import 'package:medcar_app/src/data/dataSource/remote/services/UsersService.dart';
import 'package:medcar_app/src/data/repository/AuthRepositoryImpl.dart';
import 'package:medcar_app/src/data/repository/ClientRequestsRepositoryImpl.dart';
// import 'package:medcar_app/src/data/repository/DriverCarInfoRepositoryImpl.dart';
import 'package:medcar_app/src/data/repository/DriverTripRequestsRepositoryImpl.dart';
import 'package:medcar_app/src/data/repository/DriversPositionRepositoryImpl.dart';
import 'package:medcar_app/src/data/repository/GeolocatorRepositoryImpl.dart';
import 'package:medcar_app/src/data/repository/SocketRepositoryImpl.dart';
import 'package:medcar_app/src/data/repository/UsersRepositoryImpl.dart';
import 'package:medcar_app/src/domain/models/AuthResponse.dart';
import 'package:medcar_app/src/domain/repository/AuthRepository.dart';
import 'package:medcar_app/src/domain/repository/DriversPositionRepository.dart';
import 'package:medcar_app/src/domain/repository/ClientRequestsRepository.dart';
// import 'package:medcar_app/src/domain/repository/DriverCarInfoRepository.dart';
import 'package:medcar_app/src/domain/repository/DriverTripRequestsRepository.dart';
// import 'package:medcar_app/src/domain/repository/DriversPositionRepository.dart';
import 'package:medcar_app/src/domain/repository/GeolocatorRepository.dart';
import 'package:medcar_app/src/domain/repository/SocketRepository.dart';
import 'package:medcar_app/src/domain/repository/UsersRepository.dart';
import 'package:medcar_app/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:medcar_app/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:medcar_app/src/domain/useCases/auth/LoginCarUseCase.dart';
import 'package:medcar_app/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:medcar_app/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:medcar_app/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:medcar_app/src/domain/useCases/auth/SaveUserSessionUseCase.dart';
import 'package:medcar_app/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:medcar_app/src/domain/useCases/client-requests/CreateClientRequestUseCase.dart';
// import 'package:medcar_app/src/domain/useCases/client-requests/GetByClientAssignedUseCase%20copy.dart';
// import 'package:medcar_app/src/domain/useCases/client-requests/GetByClientRequestUseCase.dart';
// import 'package:medcar_app/src/domain/useCases/client-requests/GetByDriverAssignedUseCase.dart';
import 'package:medcar_app/src/domain/useCases/client-requests/GetNearbyTripRequestUseCase.dart';
// import 'package:medcar_app/src/domain/useCases/client-requests/UpdateClientRatingUseCase.dart';
import 'package:medcar_app/src/domain/useCases/client-requests/UpdateDriverAssignedUseCase.dart';
// import 'package:medcar_app/src/domain/useCases/client-requests/UpdateDriverRatingUseCase.dart';
// import 'package:medcar_app/src/domain/useCases/client-requests/UpdateStatusClientRequestUseCase.dart';
import 'package:medcar_app/src/domain/useCases/client-requests/GetTimeAndDistanceUseCase.dart';
// import 'package:medcar_app/src/domain/useCases/driver-car-info/CreateDriverCarInfoUseCase.dart';
// import 'package:medcar_app/src/domain/useCases/driver-car-info/DriverCarInfoUseCases.dart';
// import 'package:medcar_app/src/domain/useCases/driver-car-info/GetDriverCarInfoUseCase.dart';
import 'package:medcar_app/src/domain/useCases/driver-trip-request/CreateDriverTripRequestUseCase.dart';
import 'package:medcar_app/src/domain/useCases/driver-trip-request/DriverTripRequestUseCases.dart';
import 'package:medcar_app/src/domain/useCases/driver-trip-request/GetDriverTripOffersByClientRequestUseCase.dart';
import 'package:medcar_app/src/domain/useCases/drivers-position/CreateDriverPositionUseCase.dart';
import 'package:medcar_app/src/domain/useCases/drivers-position/DeleteDriverPositionUseCase.dart';
import 'package:medcar_app/src/domain/useCases/drivers-position/DriversPositionUseCases.dart';
import 'package:medcar_app/src/domain/useCases/drivers-position/GetDriverPositionUseCase.dart';
import 'package:medcar_app/src/domain/useCases/geolocator/CreateMarkerUseCase.dart';
import 'package:medcar_app/src/domain/useCases/geolocator/FindPositionUseCase.dart';
import 'package:medcar_app/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:medcar_app/src/domain/useCases/geolocator/GetMarkerUseCase.dart';
import 'package:medcar_app/src/domain/useCases/geolocator/GetPlacemarkDataUseCase.dart';
import 'package:medcar_app/src/domain/useCases/geolocator/GetPolylineUseCase.dart';
import 'package:medcar_app/src/domain/useCases/geolocator/GetPositionStreamUseCase.dart';
import 'package:medcar_app/src/domain/useCases/socket/ConnectSocketUseCase.dart';
import 'package:medcar_app/src/domain/useCases/socket/DisconnectSocketUseCase.dart';
import 'package:medcar_app/src/domain/useCases/socket/SocketUseCases.dart';
// import 'package:medcar_app/src/domain/useCases/users/UpdateNotificationTokenUseCase.dart';
import 'package:medcar_app/src/domain/useCases/users/UpdateUserUseCase.dart';
import 'package:medcar_app/src/domain/useCases/users/UsersUseCases.dart';

import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart';

@module
abstract class AppModule {
  @injectable
  SharefPref get sharefPref => SharefPref();

  @injectable
  Socket get socket => io(
      'http://${ApiConfig.API_PROJECT}',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build());

  @injectable
  Future<String> get token async {
    String token = '';
    final userSession = await sharefPref.read('user');
    if (userSession != null) {
      AuthResponse authResponse = AuthResponse.fromJson(userSession);
      token = authResponse.token;
    }
    return token;
  }

  @injectable
  AuthService get authService => AuthService();
  @injectable
  UsersService get usersService => UsersService(token);

  @injectable
  DriversPositionService get driversPositionService => DriversPositionService();

  @injectable
  ClientRequestsService get clientRequestsService => ClientRequestsService();

  @injectable
  DriverTripRequestsService get driverTripRequestsService => DriverTripRequestsService();

  // @injectable
  // DriverCarInfoService get driverCarInfoService => DriverCarInfoService();

  @injectable
  AuthRepository get authRepository =>
      AuthRepositoryImpl(authService, sharefPref);

  @injectable
  UsersRepository get usersRepository => UsersRepositoryImpl(usersService);

  @injectable
  SocketRepository get socketRepository => SocketRepositoryImpl(socket);

  @injectable
  ClientRequestsRepository get clientRequestsRepository =>
      ClientRequestsRepositoryImpl(clientRequestsService);

  @injectable
  GeolocatorRepository get geolocatorRepository => GeolocatorRepositoryImpl();

  @injectable
  DriverPositionRepository get driversPositionRepository =>
      DriversPositionRepositoryImpl(driversPositionService);

  @injectable
  DriverTripRequestsRepository get driverTripRequestsRepository => DriverTripRequestsRepositoryImpl(driverTripRequestsService);

  // @injectable
  // DriverCarInfoRepository get driverCarInfoRepository => DriverCarInfoRepositoryImpl(driverCarInfoService);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
        login: LoginUseCase(authRepository),
        loginCar: LoginCarUseCase(authRepository),
        register: RegisterUseCase(authRepository),
        saveUserSession: SaveUserSessionUseCase(authRepository),
        getUserSession: GetUserSessionUseCase(authRepository),
        logout: LogoutUseCase(authRepository),
      );

  @injectable
  UsersUseCases get usersUseCases => UsersUseCases(
        update: UpdateUserUseCase(usersRepository),
        // updateNotificationToken: UpdateNotificationTokenUseCase(usersRepository)
      );

  @injectable
  GeolocatorUseCases get geolocatorUseCases => GeolocatorUseCases(
      findPosition: FindPositionUseCase(geolocatorRepository),
      createMarker: CreateMarkerUseCase(geolocatorRepository),
      getMarker: GetMarkerUseCase(geolocatorRepository),
      getPlacemarkData: GetPlacemarkDataUseCase(geolocatorRepository),
      getPolyline: GetPolylineUseCase(geolocatorRepository),
      getPositionStream: GetPositionStreamUseCase(geolocatorRepository));

  @injectable
  SocketUseCases get socketUseCases => SocketUseCases(
      connect: ConnectSocketUseCase(socketRepository),
      disconnect: DisconnectSocketUseCase(socketRepository));

  @injectable
  DriversPositionUseCases get driversPositionUseCases =>
      DriversPositionUseCases(
        createDriverPosition:
            CreateDriverPositionUseCase(driversPositionRepository),
        deleteDriverPosition:
            DeleteDriverPositionUseCase(driversPositionRepository),
        getDriverPosition: GetDriverPositionUseCase(driversPositionRepository)
      );

  @injectable
  ClientRequestsUseCases get clientRequestsUseCases => ClientRequestsUseCases(
        createClientRequest:
            CreateClientRequestUseCase(clientRequestsRepository),
        getTimeAndDistance: GetTimeAndDistanceUseCase(clientRequestsRepository),
        getNearbyTripRequest: GetNearbyTripRequestUseCase(clientRequestsRepository),
        updateDriverAssigned: UpdateDriverAssignedUseCase(clientRequestsRepository),
        // getByClientRequest: GetByClientRequestUseCase(clientRequestsRepository),
        // updateStatusClientRequest: UpdateStatusClientRequestUseCase(clientRequestsRepository),
        // updateClientRating: UpdateClientRatingUseCase(clientRequestsRepository),
        // updateDriverRating: UpdateDriverRatingUseCase(clientRequestsRepository),
        // getByClientAssigned: GetByClientAssignedUseCase(clientRequestsRepository),
        // getByDriverAssigned: GetByDriverAssignedUseCase(clientRequestsRepository)
      );

  @injectable
   DriverTripRequestUseCases get driverTripRequestUseCases => DriverTripRequestUseCases(
    createDriverTripRequest: CreateDriverTripRequestUseCase(driverTripRequestsRepository),
    getDriverTripOffersByClientRequest: GetDriverTripOffersByClientRequestUseCase(driverTripRequestsRepository)
  );

  // @injectable
  //  DriverCarInfoUseCases get driverCarInfoUseCases => DriverCarInfoUseCases(
  //   createDriverCarInfo: CreateDriverCarInfoUseCase(driverCarInfoRepository),
  //   getDriverCarInfo: GetDriverCarInfoUseCase(driverCarInfoRepository)
  // );
}
