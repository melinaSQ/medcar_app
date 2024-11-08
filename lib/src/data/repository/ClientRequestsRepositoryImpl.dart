// ignore_for_file: file_names

import 'package:medcar_app/src/data/dataSource/remote/services/ClientRequestsService.dart';
import 'package:medcar_app/src/domain/models/ClientRequest.dart';
import 'package:medcar_app/src/domain/models/ClientRequestResponse.dart';
// import 'package:medcar_app/src/domain/models/StatusTrip.dart';
import 'package:medcar_app/src/domain/models/TimeAndDistanceValues.dart';
import 'package:medcar_app/src/domain/repository/ClientRequestsRepository.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';

class ClientRequestsRepositoryImpl implements ClientRequestsRepository {
  ClientRequestsService clientRequestsService;

  ClientRequestsRepositoryImpl(this.clientRequestsService);

  @override
  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequets(
      double originLat,
      double originLng,
      double destinationLat,
      double destinationLng) {
    return clientRequestsService.getTimeAndDistanceClientRequets(
        originLat, originLng, destinationLat, destinationLng);
  }

  @override
  Future<Resource<int>> create(ClientRequest clientRequest) {
    return clientRequestsService.create(clientRequest);
  }

  @override
  Future<Resource<List<ClientRequestResponse>>> getNearbyTripRequest(
      double driverLat, double driverLng) {
// Debe ser double
    return clientRequestsService.getNearbyTripRequest(driverLat, driverLng);
  }
      
  // @override
  // Future<Resource<bool>> updateDriverAssigned(int idClientRequest, int idDriver, double fareAssigned) {
  //   return clientRequestsService.updateDriverAssigned(idClientRequest, idDriver, fareAssigned);
  // }

  // @override
  // Future<Resource<ClientRequestResponse>> getByClientRequest(int idClientRequest) {
  //   return clientRequestsService.getByClientRequest(idClientRequest);
  // }

  // @override
  // Future<Resource<bool>> updateStatus(int idClientRequest, StatusTrip statusTrip) {
  //   return clientRequestsService.updateStatus(idClientRequest, statusTrip);
  // }

  // @override
  // Future<Resource<bool>> updateClientRating(int idClientRequest, double rating) {
  //   return clientRequestsService.updateClientRating(idClientRequest, rating);
  // }

  // @override
  // Future<Resource<bool>> updateDriverRating(int idClientRequest, double rating) {
  //   return clientRequestsService.updateDriverRating(idClientRequest, rating);
  // }

  // @override
  // Future<Resource<List<ClientRequestResponse>>> getByClientAssigned(int idClient) {
  //   return clientRequestsService.getByClientAssigned(idClient);
  // }

  // @override
  // Future<Resource<List<ClientRequestResponse>>> getByDriverAssigned(int idDriver) {
  //   return clientRequestsService.getByDriverAssigned(idDriver);
  // }
}
