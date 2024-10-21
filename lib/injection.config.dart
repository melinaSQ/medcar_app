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
import 'package:medcar_app/src/data/dataSource/remote/services/UsersService.dart'
    as _i761;
import 'package:medcar_app/src/di/AppModule.dart' as _i132;
import 'package:medcar_app/src/domain/repository/AuthRepository.dart' as _i101;
import 'package:medcar_app/src/domain/repository/GeolocatorRepository.dart'
    as _i113;
import 'package:medcar_app/src/domain/repository/UsersRepository.dart' as _i507;
import 'package:medcar_app/src/domain/useCases/auth/AuthUseCases.dart' as _i17;
import 'package:medcar_app/src/domain/useCases/geolocator/GeolocatorUseCases.dart'
    as _i755;
import 'package:medcar_app/src/domain/useCases/users/UsersUseCases.dart'
    as _i66;

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
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i744.AuthService>(() => appModule.authService);
    gh.factory<_i761.UsersService>(() => appModule.usersService);
    gh.factory<_i101.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i507.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i113.GeolocatorRepository>(
        () => appModule.geolocatorRepository);
    gh.factory<_i17.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i66.UsersUseCases>(() => appModule.usersUseCases);
    gh.factory<_i755.GeolocatorUseCases>(() => appModule.geolocatorUseCases);
    return this;
  }
}

class _$AppModule extends _i132.AppModule {}
