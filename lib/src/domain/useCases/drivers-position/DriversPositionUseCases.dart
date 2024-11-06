import 'package:medcar_app/src/domain/useCases/drivers-position/CreateDriverPositionUseCase.dart';
import 'package:medcar_app/src/domain/useCases/drivers-position/DeleteDriverPositionUseCase.dart';
// import 'package:medcar_app/src/domain/useCases/drivers-position/GetDriverPositionUseCase.dart';

class DriversPositionUseCases {

  CreateDriverPositionUseCase createDriverPosition;
  DeleteDriverPositionUseCase deleteDriverPosition;
  // GetDriverPositionUseCase getDriverPosition;

  DriversPositionUseCases({
    required this.createDriverPosition,
    required this.deleteDriverPosition,
    // required this.getDriverPosition,
  });

}