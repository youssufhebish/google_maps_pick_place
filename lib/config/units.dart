import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Customizing the Position and get it
Position customPosition(LatLng latLng) => Position(
      longitude: latLng.longitude,
      latitude: latLng.latitude,
      timestamp: null,
      speedAccuracy: 0.0,
      heading: 0.0,
      altitude: 0.0,
      speed: 0.0,
      accuracy: 0.0,
    );

/// Custom Marker
Marker customMarker(
  LatLng? latLng,
  void Function(LatLng)? onDragEnd, {
  MarkerColor markerColor = MarkerColor.red,
}) =>
    Marker(
      draggable: true,
      onDragEnd: onDragEnd,
      markerId: const MarkerId('0'),
      position: latLng!,
      icon: colors[markerColor]!,
    );

/// Colors map that returns the color of the marker
Map<MarkerColor, BitmapDescriptor> colors = {
  MarkerColor.red:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  MarkerColor.green:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  MarkerColor.blue:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  MarkerColor.orange:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  MarkerColor.yellow:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
  MarkerColor.cyan:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
  MarkerColor.azure:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  MarkerColor.rose:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
  MarkerColor.magenta:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
  MarkerColor.violet:
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
};

/// Marker colors enum
enum MarkerColor {
  red,
  green,
  blue,
  orange,
  yellow,
  cyan,
  azure,
  rose,
  magenta,
  violet,
}