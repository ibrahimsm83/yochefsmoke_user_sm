import 'package:google_maps_webservice/places.dart';

class Location {
  double? _latitude, _longitude, _heading;
  //String? _province,_country,_city,_area,_place;
  String? _subLocality,
      _street,
      _name2,
      _subAdministrativeArea,
      _administrativeArea,
      _country,
      _postalCode,
      _locality;
  String? _name;

  //final String? name;
  Location(
      {required double latitude,
      required double longitude,
      double? heading,
      String? name,
      String? locality,
      subLocality,
      street,
      name2,
      subAdministrativeArea,
      administrativeArea,
      country,
      postalCode}) {
    _latitude = latitude;
    _longitude = longitude;
    _heading = heading;
    this._subLocality = subLocality;
    this._street = street;
    this._country = country;
    this._name2 = name2;
    this._subAdministrativeArea = subAdministrativeArea;
    this._administrativeArea = administrativeArea;
    this._postalCode = postalCode;
    this._name = name;
    this._locality = locality;
  }

  double get latitude => _latitude!;

  set latitude(double value) {
    _latitude = value;
  }

  double get heading => _heading ??= 0;

  set heading(value) {
    _heading = value;
  }

  get longitude => _longitude!;

  set longitude(value) {
    _longitude = value;
  }

  factory Location.continuous(
      double latitude, double longitude, double heading) {
    return Location(latitude: latitude, longitude: longitude, heading: heading);
  }

  factory Location.fromLocalMap(double latitude, double longitude, {Map? map}) {
    Location loc = Location(
      latitude: latitude,
      longitude: longitude,
      name2: map?["name"],
      street: map?["street"],
      country: map?["country"],
      postalCode: map?["postalCode"],
      administrativeArea: map?["administrativeArea"],
      subAdministrativeArea: map?["subAdministrativeArea"],
      subLocality: map?["subLocality"],
      locality: map?["locality"],
    );
    return loc;
  }

  factory Location.fromMap(Map map) {
    Location loc = Location(
        latitude: double.tryParse(map["lat"])!,
        longitude: double.tryParse(map["long"])!,
        name: map["location"]);
    return loc;
  }

  factory Location.fromAddressMap(Map map) {
    Location loc = Location(
        latitude: double.parse(map["latitude"]),
        longitude: double.parse(map["longitude"]),
        name: map["address"]);
    return loc;
  }

  Map<String, dynamic> toAddressMap() {
    return {
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "address": name,
    };
  }

  factory Location.fromSocketMap(Map map) {
    return Location(
      latitude: double.parse(map["latitude"]),
      longitude: double.parse(map["longitude"]),
      heading: double.parse(map["bearing"]),
    );
  }

  factory Location.fromPlaceDetails(PlacesDetailsResponse res,
      {String name = ""}) {
    var loc = res.result.geometry!.location;
    return Location(latitude: loc.lat, longitude: loc.lng, name: name);
  }

  String get name {
    return _name ??
        "${_getValue(_subLocality ?? "")} ${_getValue(_street ?? "")} "
            "${_getValue(_name2 ?? "")} ${_getValue(_subAdministrativeArea ?? "")} "
            "${_getValue(_administrativeArea ?? "")} ${_getValue(_locality ?? "")} ${_getValue(_country ?? "")} $_postalCode";
  }

  String _getValue(String val) {
    return val.isNotEmpty ? "$val," : "";
  }

  String get address {
    return name;
  }

  get country => _country;
  get state => _administrativeArea;
  get postalCode => _postalCode;
  get city => _locality;
}
