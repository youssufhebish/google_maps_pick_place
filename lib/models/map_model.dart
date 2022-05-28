class MapModelResultsGeometryLocation {

  double? lat;
  double? lng;

  MapModelResultsGeometryLocation({
    this.lat,
    this.lng,
  });
  MapModelResultsGeometryLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toDouble();
    lng = json['lng']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class MapModelResultsGeometry {

  MapModelResultsGeometryLocation? location;

  MapModelResultsGeometry({
    this.location,
  });
  MapModelResultsGeometry.fromJson(Map<String, dynamic> json) {
    location = (json['location'] != null) ? MapModelResultsGeometryLocation.fromJson(json['location']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class MapModelResults {

  String? formattedAddress;
  MapModelResultsGeometry? geometry;
  String? name;
  int? rating;
  int? userRatingsTotal;

  MapModelResults({
    this.formattedAddress,
    this.geometry,
    this.name,
    this.rating,
    this.userRatingsTotal,
  });
  MapModelResults.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address']?.toString();
    geometry = (json['geometry'] != null) ? MapModelResultsGeometry.fromJson(json['geometry']) : null;
    name = json['name']?.toString();
    rating = json['rating']?.toInt();
    userRatingsTotal = json['user_ratings_total']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['formatted_address'] = formattedAddress;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['name'] = name;
    data['rating'] = rating;
    data['user_ratings_total'] = userRatingsTotal;
    return data;
  }
}

class MapModel {

  List<MapModelResults?>? results;

  MapModel({
    this.results,
  });
  MapModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      final v = json['results'];
      final arr0 = <MapModelResults>[];
      v.forEach((v) {
        arr0.add(MapModelResults.fromJson(v));
      });
      results = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (results != null) {
      final v = results;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['results'] = arr0;
    }
    return data;
  }
}
