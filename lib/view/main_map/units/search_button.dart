import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../search_dialog/search_dialog.dart';
import 'with_shadow_container.dart';

class SearchButton extends StatelessWidget {
  /// The widget which will be used in search
  const SearchButton({
    required this.addressLabelState,
    required this.getLocation,
    required this.apiKey,
    required this.loader,
    required this.searchLanguage,
    Key? key,
  }) : super(key: key);

  final dynamic addressLabelState;
  /// Method which getting the location
  final dynamic Function(LatLng) getLocation;
  final String apiKey;
  final Widget loader;
  final String searchLanguage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        addressLabelState();
        showSearchDialog(context, addressLabelState, getLocation, apiKey, searchLanguage, loader,);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: withShadowDecoration(
          CircleAvatar(
            radius: 15.0,
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
          context,
        ),
      ),
    );
  }
}
