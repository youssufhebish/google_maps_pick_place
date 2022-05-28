import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../localization/language_enum.dart';
import 'units/search_widget.dart';


showSearchDialog(
  BuildContext context,
  dynamic addressLabelState,
  dynamic Function(LatLng) getLocation,
  String apiKey,
  Language mapLanguage,
  Widget loader,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          insetPadding: const EdgeInsets.all(0.0),
          child: SearchWidget(
            addressLabelState: addressLabelState,
            getLocation: getLocation,
            mapLanguage: mapLanguage,
            apiKey: apiKey,
            loader: loader,
          ),
        ),
      );
    },
  );
}
