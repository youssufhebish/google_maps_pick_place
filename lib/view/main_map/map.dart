import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../config/methods/camera_moving.dart';
import '../../config/methods/check_permission.dart';
import '../../config/units.dart';
import '../../localization/language_enum.dart';
import '../../models/address_model.dart';
import 'units/address_label.dart';
import 'units/close_map_button.dart';
import 'units/map_view.dart';
import 'units/my_location_button.dart';
import 'units/search_button.dart';

class GoogleMapsPickPlace extends StatefulWidget {
  const GoogleMapsPickPlace({
    required this.apiKey,
    this.mapLanguage = Language.arabic,
    this.getResult,
    this.initialPosition = const LatLng(29.9773, 31.1325),
    this.enableMyLocationButton = true,
    this.enableSearchButton = true,
    this.loader = const Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
    this.doneButton,
    this.errorButton,
    this.zoomFactor = 5.0,
    this.markerColor = MarkerColor.red,
    Key? key,
  }) : super(key: key);

  /// Key for Google Maps API
  final String apiKey;
  /// [mapLanguage] is the property of [GoogleMapsPickPlace] that controls search results language.
  ///
  /// It's is a [Language] that can be either [Language.arabic] or [Language.english] and other languages.
  ///
  /// It's [Language.arabic] by default.
  final Language mapLanguage;
  /// Method to get the position of the place on the map
  final Function(FullAddress)? getResult;
  /// Initial position of the map in case there's no location and GPS is off
  final LatLng initialPosition;
  /// Enable or disable the My Location button
  final bool enableMyLocationButton;
  /// Enable or disable the Search button
  final bool enableSearchButton;
  /// Widget to show while the map is loading
  final Widget loader;
  /// Widget to show when the map is done loading and apply getResult method
  final Widget? doneButton;
  /// Widget to show when there's a corruption or there's no internet connection
  final Widget? errorButton;
  /// Zoom factor of the map (default is 5.0)
  final double zoomFactor;
  /// Marker color of the map (default is red)
  final MarkerColor markerColor;

  @override
  State<GoogleMapsPickPlace> createState() => _GoogleMapsPickPlaceState();
}

class _GoogleMapsPickPlaceState extends State<GoogleMapsPickPlace> {

  bool loadingLocation = true;
  bool notConnected = true;
  bool showLabel = true;
  FullAddress fullAddress = FullAddress();
  GoogleMapController? mapController;
  Completer<GoogleMapController> completer = Completer();
  Marker marker = const Marker(
    markerId: MarkerId('1'),
  );

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          MapWidget(
            initialPosition: widget.initialPosition,
            marker: marker,
            zoomFactor: widget.zoomFactor,
            onMapCreated: onMapCreated,
            getLocation: getLocation,
          ),
          const CloseMapButton(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(widget.enableMyLocationButton) CurrentLocationButton(getCurrentLocation: getCurrentLocation),
              if (widget.enableSearchButton)
                SearchButton(
                  addressLabelState: addressLabelState,
                  mapLanguage: widget.mapLanguage,
                  getLocation: getLocation,
                  apiKey: widget.apiKey,
                  loader: widget.loader,
                ),
            ],
          ),
          if(showLabel) AddressLabel(
            address: fullAddress,
            loader: widget.loader,
            notConnected: notConnected,
            loading: loadingLocation,
            mapLanguage: widget.mapLanguage,
            onTap: (fullAddress) {
              setState(() {
                notConnected = false;
                widget.getResult!(fullAddress);
              });
              log('${fullAddress.address} \n${fullAddress.position!.latitude} \n${fullAddress.position!.longitude}');
            },
          ),
        ],
      ),
    );
  }


  /// OnMapCreated responsible for initializing the map controller
  onMapCreated(GoogleMapController controller) async {
    completer.complete(controller);
    mapController = controller;
    checkPermission(getCurrentLocation());
  }

  /// Getting location from the map by tapping
  getLocation(LatLng latLng) async {
    fullAddress.position = customPosition(latLng);
    setState(() {
      loadingLocation = true;
      notConnected = false;
    });
    List<Placemark> addressList = [];
    try{
      addressList = await geocoding.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      await cameraMoving(mapController!, fullAddress.position);
    } catch (e) {
      setState(() {
        notConnected = true;
        loadingLocation = false;
      });
      log('Error: $e');
      log('NotConnected: $notConnected');
    }
    final address = addressList.first;
    fullAddress.address = "${address.street}";
    marker = customMarker(latLng, getLocation, markerColor: widget.markerColor,);
    setState(() {loadingLocation = false;});
  }

  /// Getting the current location
  getCurrentLocation() async {
    log('GETTING LOCATION');
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      fullAddress.position = await Geolocator.getCurrentPosition();
      getLocation(LatLng(fullAddress.position!.latitude, fullAddress.position!.longitude));
    } else {
      await Geolocator.requestPermission();
      try{
        fullAddress.position = await Geolocator.getCurrentPosition();
        getLocation(LatLng(fullAddress.position!.latitude, fullAddress.position!.longitude));
        log('${fullAddress.position}');
      } catch (e) {
        getLocation(LatLng(widget.initialPosition.latitude, widget.initialPosition.longitude));
        log('Error: $e');
      }
    }
  }

  /// Showing & Hiding the address label
  dynamic addressLabelState(){
    setState(() {
      showLabel = !showLabel;
    });
  }
}