import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart' hide Location,TravelMode;
import 'package:ycsh/utils/config.dart';
import 'package:ycsh/widget/common.dart';

import '../model/location.dart';


class PlaceFinder {

  final _places = GoogleMapsPlaces(apiKey: AppConfig.GOOGLE_MAPS_API_KEY);
 // PolylinePoints _polylinePoints = PolylinePoints();

  static PlaceFinder? _instance;

  PlaceFinder._();

  factory PlaceFinder(){
    return _instance??=PlaceFinder._();
  }


  Future<Location?> findLocation(BuildContext context,) async {
    Location? loc;
    var prediction = await PlacesAutocomplete.show(
        logo: const CustomText(text:""),
        context: context,
        apiKey: AppConfig.GOOGLE_MAPS_API_KEY,
        mode: Mode.overlay,
        language: 'en',
        types: [],
        strictbounds: false,
        components: [],
      onError: (error){
          print("places autocomplete error: ${error.errorMessage}");
      }
    );
    if (prediction != null) {
   //   print(prediction.description);
      PlacesDetailsResponse res=await _places.getDetailsByPlaceId(prediction.placeId!);
      loc=Location.fromPlaceDetails(res,name: prediction.description!);
      // displayPrediction(prediction);
    }
    return loc;
  }

/*  Future<List<PointLatLng>> getDirectionBetween(Location l1, Location l2) async{
    PolylineResult result=await _polylinePoints.getRouteBetweenCoordinates(AppConfig.GOOGLE_MAPS_API_KEY,
        PointLatLng(l1.latitude, l1.longitude), PointLatLng(l2.latitude, l2.longitude),travelMode: TravelMode.driving);
    print("direction points: ${result.points.length}");
    return result.points;
    //return [];
  }*/





}