import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ycsh/model/interface.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/socket.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/config.dart';


class TrackingController extends GetxController with SocketMessageHandler{

  final SocketService loc_socket_service=SocketService(AppConfig.SOCKET_SERVER_URL);

  final Map<String,Location> _riderLocations={};

  LocationInterface? locationInterface;

  static const PICKUP = "pickup",
      DROPOFF = "dropoff",
      DIRECTION = "direction",
      CURLOC = "curloc";

  BitmapDescriptor? _dropoff_marker,_curloc_marker;

  BitmapDescriptor get dropoff_marker => _dropoff_marker!;
  BitmapDescriptor get curloc_marker => _curloc_marker??BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);

  Location? getRiderLocation(String id){
    return _riderLocations[id];
  }


  @override
  void onInit() {
    loadMarkers();
    super.onInit();
  }


  void loadMarkers(){
    _dropoff_marker=BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    _getAssetImage(AssetPath.ICON_CUR_LOC, const Size(10, 10)).then((value) {
      _curloc_marker=value;
    });
  }

  Future<BitmapDescriptor> _getAssetImage(String image,Size size){
    return BitmapDescriptor.fromAssetImage(ImageConfiguration(size: size,), image);
  }

  void connectSocket(Rider rider){
    loc_socket_service.connect(this,events: ["${SocketEvent.SEND_LOCATION}-${rider.id}"]);
  }

  void disconnectSocket(){
    loc_socket_service.disconnect();
  }

  @override
  void onEvent(String name, data) {
    super.onEvent(name, data);
    final String rider_id=data["id"].toString();
    final Location location=Location.fromSocketMap(data);
    locationInterface?.onLocationChanged(location);
    _riderLocations[rider_id]=location;
  }

}