// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:medcar_app/src/data/dataSource/local/SharefPref.dart' as _i230;
import 'package:medcar_app/src/data/dataSource/remote/services/AuthService.dart'
    as _i744;
import 'package:medcar_app/src/data/dataSource/remote/services/ClientRequestsService.dart'
    as _i962;
import 'package:medcar_app/src/data/dataSource/remote/services/DriversPositionService.dart'
    as _i580;
import 'package:medcar_app/src/data/dataSource/remote/services/DriverTripRequestsService.dart'
    as _i24;
import 'package:medcar_app/src/data/dataSource/remote/services/UsersService.dart'
    as _i761;
import 'package:medcar_app/src/di/AppModule.dart' as _i132;
import 'package:medcar_app/src/domain/repository/AuthRepository.dart' as _i101;
import 'package:medcar_app/src/domain/repository/ClientRequestsRepository.dart'
    as _i860;
import 'package:medcar_app/src/domain/repository/DriversPositionRepository.dart'
    as _i810;
import 'package:medcar_app/src/domain/repository/DriverTripRequestsRepository.dart'
    as _i532;
import 'package:medcar_app/src/domain/repository/GeolocatorRepository.dart'
    as _i113;
import 'package:medcar_app/src/domain/repository/SocketRepository.dart'
    as _i461;
import 'package:medcar_app/src/domain/repository/UsersRepository.dart' as _i507;
import 'package:medcar_app/src/domain/useCases/auth/AuthUseCases.dart' as _i17;
import 'package:medcar_app/src/domain/useCases/client-requests/ClientRequestsUseCases.dart'
    as _i963;
import 'package:medcar_app/src/domain/useCases/driver-trip-request/DriverTripRequestUseCases.dart'
    as _i558;
import 'package:medcar_app/src/domain/useCases/drivers-position/DriversPositionUseCases.dart'
    as _i1033;
import 'package:medcar_app/src/domain/useCases/geolocator/GeolocatorUseCases.dart'
    as _i755;
import 'package:medcar_app/src/domain/useCases/socket/SocketUseCases.dart'
    as _i265;
import 'package:medcar_app/src/domain/useCases/users/UsersUseCases.dart'
    as _i66;
import 'package:socket_io_client/socket_io_client.dart' as _i414;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i230.SharefPref>(() => appModule.sharefPref);
    gh.factory<_i414.Socket>(() => appModule.socket);
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i744.AuthService>(() => appModule.authService);
    gh.factory<_i761.UsersService>(() => appModule.usersService);
    gh.factory<_i580.DriversPositionService>(
        () => appModule.driversPositionService);
    gh.factory<_i962.ClientRequestsService>(
        () => appModule.clientRequestsService);
    gh.factory<_i24.DriverTripRequestsService>(
        () => appModule.driverTripRequestsService);
    gh.factory<_i101.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i507.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i461.SocketRepository>(() => appModule.socketRepository);
    gh.factory<_i860.ClientRequestsRepository>(
        () => appModule.clientRequestsRepository);
    gh.factory<_i113.GeolocatorRepository>(
        () => appModule.geolocatorRepository);
    gh.factory<_i810.DriverPositionRepository>(
        () => appModule.driversPositionRepository);
    gh.factory<_i532.DriverTripRequestsRepository>(
        () => appModule.driverTripRequestsRepository);
    gh.factory<_i17.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i66.UsersUseCases>(() => appModule.usersUseCases);
    gh.factory<_i755.GeolocatorUseCases>(() => appModule.geolocatorUseCases);
    gh.factory<_i265.SocketUseCases>(() => appModule.socketUseCases);
    gh.factory<_i1033.DriversPositionUseCases>(
        () => appModule.driversPositionUseCases);
    gh.factory<_i963.ClientRequestsUseCases>(
        () => appModule.clientRequestsUseCases);
    gh.factory<_i558.DriverTripRequestUseCases>(
        () => appModule.driverTripRequestUseCases);
    return this;
  }
}

class _$AppModule extends _i132.AppModule {}
