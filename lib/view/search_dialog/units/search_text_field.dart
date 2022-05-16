import 'dart:ui';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    required this.searchController,
    required this.getPlaces,
    required this.apiKey,
    required this.addressLabelState,
    Key? key,
  })
      : super(key: key);

  /// The [searchController] for the search text field.
  final TextEditingController searchController;
  /// The api key for google maps services.
  final String apiKey;
  /// The method which get places by search.
  final Function(String apiKey, String keyword, ) getPlaces;
  /// The method which hide the address label.
  final dynamic addressLabelState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 60.0,
            decoration: BoxDecoration(
              color: MediaQuery.of(context).platformBrightness ==
                  Brightness.light
                  ? Colors.white.withOpacity(0.25)
                  : Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              controller: searchController,
              style: TextStyle(
                color: MediaQuery.of(context).platformBrightness == Brightness.light? Colors.black : Colors.white,
              ),
              onSubmitted: (value) {
                if(value.isNotEmpty){
                  getPlaces(apiKey, value);
                  debugPrint(value);
                }
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
                suffixIcon: _ActionButton(
                    searchController: searchController,
                    getPlaces: getPlaces,
                    apiKey: apiKey,
                    addressLabelState: addressLabelState),
                hintText: Directionality.of(context).name == 'rtl'
                    ? 'ابحث عن موقع'
                    : 'Search for a location',
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.searchController,
    required this.getPlaces,
    required this.apiKey,
    required this.addressLabelState,
    Key? key,
  })
      : super(key: key);

  /// The [searchController] for the search text field.
  final TextEditingController searchController;
  /// The api key for google maps services.
  final String apiKey;
  /// The method which get places by search.
  final Function(String apiKey, String keyword, ) getPlaces;
  /// The method which hide the address label.
  final dynamic addressLabelState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            if(searchController.text.isNotEmpty){
              getPlaces(apiKey, searchController.text,);
              debugPrint(searchController.text);
            }
          },
          child: Icon(Icons.search, color: Theme.of(context).primaryColor,),
        ),
        const SizedBox(width: 5.0,),
        InkWell(
          onTap: () {
            if(searchController.text.isNotEmpty) {
              searchController.clear();
            } else {
              addressLabelState();
              Navigator.pop(context);
            }
          },
          child: Icon(Icons.cancel_outlined, color: Theme.of(context).primaryColor,),
        ),
        const SizedBox(width: 5.0,),
      ],
    );
  }
}
