// ignore_for_file: file_names

// import 'package:medcar_app/src/domain/models/DriverTripRequest.dart';
// import 'package:medcar_app/src/presentation/utils/BlocFormItem.dart';

abstract class DriverClientRequestsEvent {}

// class InitDriverClientRequest extends DriverClientRequestsEvent{}
class GetNearbyTripRequest extends DriverClientRequestsEvent {}
// class CreateDriverTripRequest extends DriverClientRequestsEvent {
//   final DriverTripRequest driverTripRequest;
//   CreateDriverTripRequest({required this.driverTripRequest});
// }

// class FareOfferedChange extends DriverClientRequestsEvent {
//   final BlocFormItem fareOffered;
//   FareOfferedChange({required this.fareOffered});
// }

// class ListenNewClientRequestSocketIO extends DriverClientRequestsEvent {}
// class EmitNewDriverOfferSocketIO extends DriverClientRequestsEvent{
//   final int idClientRequest;
//   EmitNewDriverOfferSocketIO({required this.idClientRequest});
// }