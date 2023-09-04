import 'dart:async';
import 'dart:io';
import 'package:background_location/background_location.dart' hide Location;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/location.dart';

class LocationService extends GetxService{

  static const LatLng def = LatLng(37.42796133580664, -122.085749655962);

  static LocationService? _instance;

  LocationService._();

  factory LocationService(){
    return _instance??=LocationService._();
  }


  Future<LocationPermission> _checkForPermission() async{
    return Geolocator.requestPermission();
  }

  Future<bool> _checkServiceEnabled(){
    return Geolocator.isLocationServiceEnabled();
  }

  Future<bool> _triggerSettings(){
    return Geolocator.openLocationSettings();
  }

  Future<Location> geoCode(LatLng position) async{
    late Location location;
    try{
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,
      position.longitude,);

      var place=placemarks[0];
      print("locality: ${place.toJson()}");
      location=Location.fromLocalMap(position.latitude, position.longitude,
          map:place.toJson());// uncomment this
    }
    catch(ex){
      location=Location.fromLocalMap(position.latitude, position.longitude);
    }
    return location;
  }

  Future<Location?> getCurrentLocation() async{
    Location? location;
    LocationPermission permission=await _checkForPermission();
    print("permission is: $permission");
    if(permission==LocationPermission.always || permission==LocationPermission.whileInUse){
      await Geolocator.getCurrentPosition().then((position) async{
        location= await geoCode(LatLng(position.latitude, position.longitude));
      }).catchError((ex){
        print("location exception $ex");
      });
      //Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
    }
    return location;

  }

  StreamSubscription<Position>? _sub;
  StreamSubscription<ServiceStatus>? _sub2;

  void getContinuousLocation(Function(Location location) onLocationChanged) async{
    LocationPermission permission=await _checkForPermission();
    if(permission==LocationPermission.always || permission==LocationPermission.whileInUse) {
      bool enabled=await _checkServiceEnabled();
      if(!enabled){
        _triggerSettings();
        _sub2=Geolocator.getServiceStatusStream().listen((status) {
          if(status==ServiceStatus.enabled){
            getContinuousLocation(onLocationChanged);
            _sub2?.cancel();
          }
        });
      }
      else{
        BackgroundLocation.setAndroidNotification(
          title: "Alert",
          message: "Location is taken continuously...",
          icon: "@mipmap/ic_launcher",
        );

        BackgroundLocation.startLocationService(forceAndroidLocationManager: false,);

        //    BackgroundLocation.setAndroidConfiguration(10000);

        /*   BackgroundLocation.getLocationUpdates((location) {
         print("yohe ${location.bearing}");
       });*/

        _sub = Geolocator.getPositionStream(
            locationSettings: Platform.isAndroid?AndroidSettings(
          intervalDuration: const Duration(seconds: 10),
          accuracy: LocationAccuracy.bestForNavigation,
          forceLocationManager:false,
          //distanceFilter: 100,
          //   forceLocationManager: true,
          //intervalDuration: const Duration(seconds: 10),
        ):Platform.isIOS?AppleSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          activityType: ActivityType.fitness,
          //   distanceFilter: 100,
          pauseLocationUpdatesAutomatically: true,
        ): LocationSettings(
          //   timeLimit: const Duration(seconds: 2)
        )).listen((position) {
          onLocationChanged(Location.continuous(position.latitude,
              position.longitude, position.heading));
        });
      }
    }
  }

  void cancelContinuousLocation(){
    _sub?.cancel();
    BackgroundLocation.stopLocationService();
  }

  double getDistanceBetween(Location l1,Location l2){
    final double meters=Geolocator.distanceBetween(l1.latitude, l1.longitude, l2.latitude, l2.longitude);
    return meters/1000;
    // return km/1.609;
  }

  double getAverageTimeCar(double km){
    return km/30;// hour
  }


}