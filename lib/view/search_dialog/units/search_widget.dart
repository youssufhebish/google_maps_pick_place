import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../models/map_model.dart';
import 'search_list.dart';
import 'search_text_field.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
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
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  bool isError = false;
  bool getSearched = false;
  MapModel mapModel = MapModel(results: []);

  @override
  dispose() {
    searchController.dispose();
    mapModel = MapModel(results: []);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SearchTextField(
          addressLabelState: widget.addressLabelState,
          searchController: searchController,
          apiKey: widget.apiKey,
          getPlaces: getPlaces,
        ),
        SearchList(
          getSearched: getSearched,
          isSearching: isSearching,
          isError: isError,
          mapModel: mapModel,
          getLocation: widget.getLocation,
          addressLabelState: widget.addressLabelState,
          loader: widget.loader,
        ),
      ],
    );
  }
  getPlaces(String apiKey, String keyword,) async {
    setState(() {
      isSearching = true;
      getSearched = true;
    });
    try{
      Response response = await Dio().get(
        'https://maps.googleapis.com/maps/api/place/textsearch/json',
        queryParameters: {
          'query' : keyword,
          'key' : apiKey,
          'language' : widget.searchLanguage,
        },
      );
      mapModel = MapModel.fromJson(response.data);

      setState(() {
        isSearching = false;
      });
    } catch(e) {
      debugPrint('Error : $e');
      setState(() {
        isError = true;
      });
    }
  }
}