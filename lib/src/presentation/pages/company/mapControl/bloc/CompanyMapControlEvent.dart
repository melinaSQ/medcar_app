// ignore_for_file: file_names

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medcar_app/src/domain/models/CompanyPosition.dart';

abstract class CompanyMapControlEvent {}

class CompanyMapControlInitEvent extends CompanyMapControlEvent {}

class FindPosition extends CompanyMapControlEvent {}

class ChangeMapCameraPosition extends CompanyMapControlEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}

class OnCameraMove extends CompanyMapControlEvent {
  CameraPosition cameraPosition;
  OnCameraMove({required this.cameraPosition});
}

class OnCameraIdle extends CompanyMapControlEvent {}

class OnAutoCompletedPickUpSelected extends CompanyMapControlEvent {
  double lat;
  double lng;
  String pickUpDescription;
  OnAutoCompletedPickUpSelected(
      {required this.lat, required this.lng, required this.pickUpDescription});
}

class OnAutoCompletedDestinationSelected extends CompanyMapControlEvent {
  double lat;
  double lng;
  String destinationDescription;
  OnAutoCompletedDestinationSelected(
      {required this.lat,
      required this.lng,
      required this.destinationDescription});
}

class ListenDriversPositionSocketIO extends CompanyMapControlEvent {}
class ListenDriversDisconnectedSocketIO extends CompanyMapControlEvent {}
class RemoveDriverPositionMarker extends CompanyMapControlEvent {
  final String idSocket;
  RemoveDriverPositionMarker({ required this.idSocket });
}
class AddDriverPositionMarker extends CompanyMapControlEvent {

  final String idSocket;
  final int id;
  final double lat;
  final double lng;

  AddDriverPositionMarker({
    required this.idSocket,
    required this.id,
    required this.lat,
    required this.lng,
  });

  
}

class AddMyPositionMarker extends CompanyMapControlEvent {
  final double lat;
  final double lng;
  AddMyPositionMarker({required this.lat, required this.lng});
}


//

class UpdateLocation extends CompanyMapControlEvent {
  final Position position;
  UpdateLocation({required this.position});
}

class EmitCompanyPositionSocketIO extends CompanyMapControlEvent {}


// class StopLocation extends CompanyMapControlEvent {}

// class EmitCompanyPositionSocketIO extends CompanyMapControlEvent {}

class SaveLocationData extends CompanyMapControlEvent {
  final CompanyPosition companyPosition;
  SaveLocationData({required this.companyPosition});
}

// class DeleteLocationData extends CompanyMapControlEvent {
//   final int idDriver;
//   DeleteLocationData({required this.idDriver});
// }

