// ignore_for_file: avoid_print, file_names

import 'dart:async';
import 'package:image/image.dart' as img;

// import 'dart:convert';
// import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medcar_app/blocSocketIO/BlocSocketIO.dart';
import 'package:medcar_app/src/domain/models/PlacemarkData.dart';
// import 'package:medcar_app/src/domain/useCases/drivers-position%20copy/CompaniesPositionUseCases.dart';
import 'package:medcar_app/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:medcar_app/src/domain/useCases/socket/SocketUseCases.dart';
import 'package:medcar_app/src/presentation/pages/company/mapControl/bloc/CompanyMapControlEvent.dart';
import 'package:medcar_app/src/presentation/pages/company/mapControl/bloc/CompanyMapControlState.dart';
// import 'package:socket_io_client/socket_io_client.dart';

class CompanyMapControlBloc
    extends Bloc<CompanyMapControlEvent, CompanyMapControlState> {
  SocketUseCases socketUseCases;
  GeolocatorUseCases geolocatorUseCases;
  // AuthUseCases authUseCases;
  // DriversPositionUseCases driversPositionUseCases;
  StreamSubscription? positionSubscription;
  BlocSocketIO blocSocketIO;

  CompanyMapControlBloc(
    this.blocSocketIO,
    this.geolocatorUseCases,
    this.socketUseCases,
    // this.authUseCases,
    // this.driversPositionUseCases,
  ) : super(CompanyMapControlState()) {
    //
    on<CompanyMapControlInitEvent>((event, emit) {
      Completer<GoogleMapController> controller =
          Completer<GoogleMapController>();
      emit(
        state.copyWith(controller: controller),
      );
    });

    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();
      add(ChangeMapCameraPosition(
          lat: position.latitude, lng: position.longitude));

      //
      // add(AddMyPositionMarker(lat: position.latitude, lng: position.longitude));

      // Stream<Position> positionStream =
      //     geolocatorUseCases.getPositionStream.run();
      // positionSubscription = positionStream.listen((Position position) {
      //   add(UpdateLocation(position: position));
      //   add(SaveLocationData(
      //     driverPosition: DriverPosition(
      //       idDriver: state.idDriver!,
      //       lat: position.latitude,
      //       lng: position.longitude,
      //     ),
      //   ));
      // });

      //
      emit(state.copyWith(
        position: position,
      ));
    });


    on<AddMyPositionMarker>((event, emit) async {
      // Redimensionar imagen
      Future<BitmapDescriptor> getResizedBitmapDescriptor(
          String assetPath, int width, int height) async {
        // Cargar la imagen
        ByteData data = await rootBundle.load(assetPath);
        Uint8List bytes = data.buffer.asUint8List();

        // Decodificar y redimensionar la imagen
        img.Image originalImage = img.decodeImage(bytes)!;
        img.Image resizedImage =
            img.copyResize(originalImage, width: width, height: height);

        // Codificar la imagen redimensionada
        Uint8List resizedBytes =
            Uint8List.fromList(img.encodePng(resizedImage));

        // ignore: deprecated_member_use
        return BitmapDescriptor.fromBytes(resizedBytes);
      }

      // Crea los marcadores usando las imágenes redimensionadas
      BitmapDescriptor descriptor = await getResizedBitmapDescriptor(
          'assets/img/medical_pin2.png', 80, 80); // Cambia el tamaño a 64x64
      // 'assets/img/car_pin.png', 80, 80); // Cambia el tamaño a 64x64

      // BitmapDescriptor descriptor = await geolocatorUseCases.createMarker.run('assets/img/car_pin.png');
      Marker marker = geolocatorUseCases.getMarker.run(
          'my_location', event.lat, event.lng, 'Mi posicion', '', descriptor);
      emit(state.copyWith(
        markers: {marker.markerId: marker},
      ));
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController =
            await state.controller!.future;
        await googleMapController
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(event.lat, event.lng),
          zoom: 17,
          bearing: 0,
        )));
      } catch (e) {
        print('ERROR EN ChangeMapCameraPosition: $e');
      }
    });

    on<OnCameraMove>((event, emit) {
      emit(state.copyWith(cameraPosition: event.cameraPosition));
    });

    on<OnCameraIdle>((event, emit) async {
      try {
        PlacemarkData placemarkData =
            await geolocatorUseCases.getPlacemarkData.run(state.cameraPosition);
        emit(state.copyWith(placemarkData: placemarkData));
      } catch (e) {
        print('OnCameraIdle Error: $e');
      }
    });

    on<OnAutoCompletedPickUpSelected>((event, emit) {
      emit(state.copyWith(
          pickUpLatLng: LatLng(event.lat, event.lng),
          pickUpDescription: event.pickUpDescription));
    });

    on<OnAutoCompletedDestinationSelected>((event, emit) {
      emit(state.copyWith(
          destinationLatLng: LatLng(event.lat, event.lng),
          destinationDescription: event.destinationDescription));
    });

    on<ListenDriversPositionSocketIO>((event, emit) async {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.on('new_driver_position', (data) {
          add(AddDriverPositionMarker(
              idSocket: data['id_socket'] as String,
              id: data['id'] as int,
              lat: data['lat'] as double,
              lng: data['lng'] as double));
        });
      }
    });

    on<ListenDriversDisconnectedSocketIO>((event, emit) {
      if (blocSocketIO.state.socket != null) {
        blocSocketIO.state.socket?.on('driver_disconnected', (data) {
          print('Id: ${data['id_socket']}');
          add(RemoveDriverPositionMarker(
              idSocket: data['id_socket'] as String));
        });
      }
    });

    on<RemoveDriverPositionMarker>((event, emit) {
      emit(state.copyWith(
          markers: Map.of(state.markers)..remove(MarkerId(event.idSocket))));
    });

    on<AddDriverPositionMarker>((event, emit) async {
      Future<BitmapDescriptor> getResizedBitmapDescriptor(
          String assetPath, int width, int height) async {
        // Cargar la imagen
        ByteData data = await rootBundle.load(assetPath);
        Uint8List bytes = data.buffer.asUint8List();

        // Decodificar y redimensionar la imagen
        img.Image originalImage = img.decodeImage(bytes)!;
        img.Image resizedImage =
            img.copyResize(originalImage, width: width, height: height);

        // Codificar la imagen redimensionada
        Uint8List resizedBytes =
            Uint8List.fromList(img.encodePng(resizedImage));

        // ignore: deprecated_member_use
        return BitmapDescriptor.fromBytes(resizedBytes);
      }

      // Crea los marcadores usando las imágenes redimensionadas
      BitmapDescriptor descriptor = await getResizedBitmapDescriptor(
          'assets/img/ambu_pin.png', 80, 80); // Cambia el tamaño a 64x64
      // 'assets/img/car_pin.png', 80, 80); // Cambia el tamaño a 64x64

      // BitmapDescriptor descriptor =
      //     await geolocatorUseCases.createMarker.run('assets/img/car_pin.png');
      Marker marker = geolocatorUseCases.getMarker.run(event.idSocket,
          event.lat, event.lng, 'Conductor disponible', '', descriptor);
      emit(state.copyWith(
          markers: Map.of(state.markers)..[marker.markerId] = marker));
    });

    //extras de driver
    on<UpdateLocation>((event, emit) async {
      add(AddMyPositionMarker(
          lat: event.position.latitude, lng: event.position.longitude));
      add(ChangeMapCameraPosition(
          lat: event.position.latitude, lng: event.position.longitude));
      emit(state.copyWith(position: event.position));
      add(EmitCompanyPositionSocketIO());
    });

    // on<StopLocation>((event, emit) {
    //   positionSubscription?.cancel();
    //   add(DeleteLocationData(idDriver: state.idDriver!));
    // });

    on<EmitCompanyPositionSocketIO>((event, emit) async {
      blocSocketIO.state.socket?.emit('change_driver_position', {
        'id': state.idCompany,
        'lat': state.position!.latitude,
        'lng': state.position!.longitude,
      });
    });

    // on<SaveLocationData>((event, emit) async {
    //   await CompaniesPositionUseCases.createDriverPosition
    //       .run(event.driverPosition);
    // });

    // on<DeleteLocationData>((event, emit) async {
    //   await driversPositionUseCases.deleteDriverPosition.run(event.idDriver);
    // });
  }
}
