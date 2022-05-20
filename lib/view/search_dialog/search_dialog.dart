import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'units/search_widget.dart';


showSearchDialog(
  BuildContext context,
  dynamic addressLabelState,
  dynamic Function(LatLng) getLocation,
  String apiKey,
  String searchLanguage,
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
            searchLanguage: searchLanguage,
            apiKey: apiKey,
            loader: loader,
          ),
        ),
      );
    },
  );
}
