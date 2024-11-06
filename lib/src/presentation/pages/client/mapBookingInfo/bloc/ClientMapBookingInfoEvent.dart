// ignore_for_file: file_names

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';

abstract class ClientMapBookingInfoEvent {}

class ClientMapBookingInfoInitEvent extends ClientMapBookingInfoEvent {
  final LatLng pickUpLatLng;
  final LatLng destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;
  ClientMapBookingInfoInitEvent({
    required this.pickUpLatLng,
    required this.destinationLatLng,
    required this.pickUpDescription,
    required this.destinationDescription,
  });
}


class ChangeMapCameraPosition extends ClientMapBookingInfoEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}

class CreateClientRequest extends ClientMapBookingInfoEvent {}
class GetTimeAndDistanceValues extends ClientMapBookingInfoEvent {}

class AddPolyline extends ClientMapBookingInfoEvent {}
// class EmitNewClientRequestSocketIO extends ClientMapBookingInfoEvent {
//   final int idClientRequest;
//   EmitNewClientRequestSocketIO({required this.idClientRequest}); 
// }


//extras para la hora de reocgida y los dtaos del paciente
class PatientDataChanged extends ClientMapBookingInfoEvent {
  final BlocFormItem patientData;

  PatientDataChanged({required this.patientData});
}

class PickUpTimeChanged extends ClientMapBookingInfoEvent {
  final BlocFormItem pickupDate;

  PickUpTimeChanged({required this.pickupDate});
}
