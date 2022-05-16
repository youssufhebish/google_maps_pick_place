import 'package:geolocator/geolocator.dart';

/// Full address model which contains position & typed address
class FullAddress {
  /// Position of the address
  Position? position;
  /// Formatted address
  String? address;

  FullAddress({
    this.position,
    this.address,
  });
}

