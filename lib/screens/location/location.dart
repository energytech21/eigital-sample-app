import 'package:eigital_sample_app/screens/location/location_bloc.dart';
import 'package:eigital_sample_app/screens/location/location_event.dart';
import 'package:eigital_sample_app/screens/location/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationWidget extends StatelessWidget {

  late GoogleMapController _controller;

  LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: [
            BlocBuilder<LocationBloc, LocationState>(
                bloc: context.read<LocationBloc>(),
                buildWhen: (prev,newState) => true,
                builder: (context, state) {
                  if (state is LocationInitialState) {
                    context.read<LocationBloc>().add(GetLocationEvent());
                    return Center(child: Text('Initializing maps'));
                  }
                  if (state is LocationInitializedState) {
                    return GoogleMap(
                        mapToolbarEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        polylines: Set<Polyline>.of(state.polylines.values),
                        markers: Set<Marker>.of(state.markers.values),
                        initialCameraPosition: CameraPosition(
                            target: state.currentLocation, zoom: 19),
                            onMapCreated: (controller) => _controller = controller);
                  }

                  return Container();
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                MaterialButton(
                  child: Text('Get Random Location',style: TextStyle(color: Colors.white)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => context.read<LocationBloc>().add(GetRandomLocationEvent()),
                )
              ]),
            )
          ],
        ));
  }
}
