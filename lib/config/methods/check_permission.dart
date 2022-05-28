import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// Checking the permission, get location permission and get the current location
dynamic checkPermission(Future<dynamic> getCurrentLocation) async {
  Geolocator.checkPermission().then((geoStatus) {
    log("GEO: $geoStatus");
    if (geoStatus == LocationPermission.denied) {
      Permission.location.request().then((_) =>
          getCurrentLocation);
    } else {
      getCurrentLocation;
    }
  });
}