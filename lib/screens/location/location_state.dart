
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationState {}

class LocationInitialState extends LocationState { }

class LocationInitializedState extends LocationState {
  final LatLng currentLocation;
  final Map<MarkerId, Marker> markers; 
  final Map<PolylineId, Polyline> polylines;

  LocationInitializedState(this.currentLocation, this.markers, this.polylines);
}