import 'package:google_maps_pick_place/localization/phrases.dart';

/// To get the phrases for a specific language
String getPhrase(String key, String language) {
  return '${packageLanguages[key]![language]}';
}