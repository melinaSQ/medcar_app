// ignore_for_file: file_names

import 'package:equatable/equatable.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';

class ClientDriverOffersState extends Equatable {
  final Resource? responseDriverOffers;
  final Resource? responseAssignDriver;


  const ClientDriverOffersState({
    this.responseDriverOffers,
    this.responseAssignDriver,
  });

  ClientDriverOffersState copyWith({
    Resource? responseDriverOffers,
    Resource? responseAssignDriver,
    Resource? responseRejectDriver, // Agregar aquí también
  }) {
    return ClientDriverOffersState(
      responseDriverOffers: responseDriverOffers ?? this.responseDriverOffers,
      responseAssignDriver: responseAssignDriver,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        responseDriverOffers,
        responseAssignDriver,
      ];
}
