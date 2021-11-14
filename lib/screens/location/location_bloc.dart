import 'dart:math';

import 'package:eigital_sample_app/screens/location/location_event.dart';
import 'package:eigital_sample_app/screens/location/location_state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as ltlng;
import 'package:location/location.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitialState()) {
    on<GetLocationEvent>(_getLocation);
    on<GetRandomLocationEvent>(_getRandomLocation);
  }

  Future<void> _getLocation(
      GetLocationEvent event, Emitter<LocationState> emitter) async {
    var currentLocation = await Location.instance.getLocation();
    emitter(LocationInitializedState(
        LatLng(currentLocation.latitude!, currentLocation.longitude!), {}, {}));
  }

  Future<void> _getRandomLocation(
      GetRandomLocationEvent event, Emitter<LocationState> emitter) async {
    var currentLocation = await Location.instance.getLocation();
    var curLatLng =
        LatLng(currentLocation.latitude!, currentLocation.longitude!);
    var randomLocation = await _findRandomLocation(curLatLng, 1000 * 10); // the search radius should be in 10km which translate to 1000m * 10

    //log if the distance is correct
    var distance = new ltlng.Distance().as(
        ltlng.LengthUnit.Kilometer,
        ltlng.LatLng(currentLocation.latitude!, currentLocation.longitude!),
        ltlng.LatLng(randomLocation.latitude, randomLocation.longitude));
    print(distance);

    var marker = await _generateMarker(randomLocation);
    var polyline = await _getPolyLine(curLatLng, randomLocation);

    emitter(LocationInitializedState(
        curLatLng, marker, polyline));
  }


  Future<Map<PolylineId, Polyline>> _getPolyLine(LatLng currentLocation, LatLng randomLocation) async {
    /*
    I am using directions API for this one, but since I have some billing issues on my GCP I wasnt able to use this one.
    */
    var polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDYMLbVb6HH1GmJ0ijwmazsk3NDZ1t2t_k",
      PointLatLng(currentLocation.latitude, currentLocation.longitude),
      PointLatLng(randomLocation.latitude, randomLocation.longitude),
      travelMode: TravelMode.driving,
    );
    var latLngPoints =result.points.map((e) => LatLng(e.latitude,e.longitude)).toList();
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: latLngPoints,
      width: 8,
    );
    return {id: polyline};
  }

  Future<Map<MarkerId, Marker>> _generateMarker(LatLng randomLocation) async {
    MarkerId markerId = MarkerId(1.toString());
    return {
      markerId: Marker(
          markerId: markerId,
          position: randomLocation,
          consumeTapEvents: true,
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(24, 24)),
              'assets/images/pin-48.png'))
    };
  }
  // Calculate random location
  LatLng _findRandomLocation(LatLng point, int radius) {
    double x0 = point.latitude;
    double y0 = point.longitude;

    Random random = new Random();

    double radiusInDegrees = radius / 111000;

    double u = random.nextDouble();
    double v = random.nextDouble();
    double w = radiusInDegrees * sqrt(u);
    double t = 2 * pi * v;
    double x = w * cos(t);
    double y = w * sin(t);

    double new_x = x / cos(y0);

    double foundLatitude = new_x + x0;
    double foundLongitude = y + y0;
    LatLng randomLatLng = new LatLng(foundLatitude, foundLongitude);

    return randomLatLng;
  }
}
