// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medcar_app/src/domain/models/DriverTripRequest.dart';
import 'package:medcar_app/src/domain/utils/Resource.dart';
import 'package:medcar_app/src/presentation/pages/client/driverOffers/ClientDriverOffersItem.dart';
import 'package:medcar_app/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersBloc.dart';
import 'package:medcar_app/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';
// import 'package:medcar_app/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';
import 'package:medcar_app/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersState.dart';
// import 'package:lottie/lottie.dart';

class ClientDriverOffersPage extends StatefulWidget {
  const ClientDriverOffersPage({super.key});

  @override
  State<ClientDriverOffersPage> createState() => _ClientDriverOffersPageState();
}

class _ClientDriverOffersPageState extends State<ClientDriverOffersPage> {
  // int? idClientRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (idClientRequest != null) {
      // context.read<ClientDriverOffersBloc>().add(ListenNewDriverOfferSocketIO(idClientRequest: idClientRequest!));
      // }
      context
          .read<ClientDriverOffersBloc>()
          .add(GetDriverOffers(idClientRequest: 2));
    });
  }

  @override
  Widget build(BuildContext context) {
    // idClientRequest = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: BlocListener<ClientDriverOffersBloc, ClientDriverOffersState>(
        listener: (context, state) {
          final response = state.responseDriverOffers;
          // final responseAssignDriver = state.responseAssignDriver;
          if (response is ErrorData) {
            Fluttertoast.showToast(
                msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
          // if (responseAssignDriver is Success) {
          //   Navigator.pushNamed(context, 'client/map/trip', arguments: idClientRequest);
          // }
        },
        child: BlocBuilder<ClientDriverOffersBloc, ClientDriverOffersState>(
            builder: (context, state) {
          final response = state.responseDriverOffers;

          print('state en ClientDriverOffersPage: ${state}');
          print('response en ClientDriverOffersPage: ${response}');
          if (response is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (response is Success) {
            List<DriverTripRequest> driverTripRequest =
                response.data as List<DriverTripRequest>;
            return ListView.builder(
                itemCount: driverTripRequest.length,
                itemBuilder: (context, index) {
                  // if (driverTripRequest.length == 0) {
                  //   return Column(
                  //     children: [
                  //       Text('Esperando conductores...'),
                  //       // Lottie.asset(
                  //       //   'assets/lottie/waiting_car.json',
                  //       //   width: 200,
                  //       //   height: 200,
                  //       //   fit: BoxFit.fill,
                  //       // )
                  //     ],
                  //   );
                  // }
                  // return ClientDriverOffersItem(driverTripRequest[index]);
                  return Text(
                    driverTripRequest[index].id.toString(),
                    style: TextStyle(fontSize: 25),
                  );
                });
          }
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Esperando ambulancias...',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Lottie.asset(
                //   'assets/lottie/waiting_car.json',
                //   width: 400,
                //   height: 230,
                //   // fit: BoxFit.fill,
                // )
              ],
            ),
          );
        }),
      ),
    );
  }
}
