import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../localization/language_enum.dart';
import '../../search_dialog/search_dialog.dart';
import 'with_shadow_container.dart';

class SearchButton extends StatelessWidget {
  /// The widget which will be used in search
  const SearchButton({
    required this.addressLabelState,
    required this.getLocation,
    required this.apiKey,
    required this.loader,
    required this.mapLanguage,
    Key? key,
  }) : super(key: key);

  final dynamic addressLabelState;
  /// Method which getting the location
  final dynamic Function(LatLng) getLocation;
  final String apiKey;
  final Widget loader;
  final Language mapLanguage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        addressLabelState();
        showSearchDialog(context, addressLabelState, getLocation, apiKey, mapLanguage, loader,);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: withShadowDecoration(
          CircleAvatar(
            radius: 17.0,
            backgroundColor: Colors.transparent,
            // backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light
            //     ? Colors.white
            //     : Colors.black,
            child: Icon(
              Icons.search,
              size: 25.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          context,
        ),
      ),
    );
  }
}
