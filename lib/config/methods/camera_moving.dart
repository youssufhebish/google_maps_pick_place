import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Camera moving action to animate map's camera to the marker
///
/// It's also controlling map's zoom with [zoomFactor] parameter
/// - [zoomFactor] has default value 16.0
Future cameraMoving(
  GoogleMapController mapController,
  Position? position, {
  double zoomFactor = 16.0,
}) =>
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: zoomFactor,
          target: LatLng(position!.latitude, position.longitude),
        ),
      ),
    );
