import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  /// MapWidget which showing the map and let the user pick the place from it
  const MapWidget(
      {required this.marker,
      required this.onMapCreated,
      required this.getLocation,
      this.zoomFactor = 5.0,
      required this.initialPosition,
      Key? key})
      : super(key: key);

  /// Zoom Factor which controls the map's zoom
  final double zoomFactor;
  /// Marker which represents the place picked
  final Marker marker;
  /// Method which initializing google map controller
  final void Function(GoogleMapController)? onMapCreated;
  /// Method which getting the location
  final dynamic Function(LatLng) getLocation;
  final LatLng initialPosition;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: zoomFactor,
      ),
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      compassEnabled: false,
      markers: {
        marker,
      },
      onMapCreated: onMapCreated,
      onTap: (latLng) => getLocation(latLng),
    );
  }
}
