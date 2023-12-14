import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ycsh/model/interface.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/socket.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/config.dart';
import 'dart:ui' as ui;


class TrackingController extends GetxController with SocketMessageHandler{

  final SocketService loc_socket_service=SocketService(AppConfig.SOCKET_SERVER_URL);

  final Map<String,Location> _riderLocations={};

  LocationInterface? locationInterface;

  static const PICKUP = "pickup",
      DROPOFF = "dropoff",
      DIRECTION = "direction",
      CURLOC = "curloc";

  BitmapDescriptor? _dropoff_marker;

  BitmapDescriptor get dropoff_marker => _dropoff_marker!;
  BitmapDescriptor get curloc_marker => _markerBytes != null
      ? BitmapDescriptor.fromBytes(_markerBytes!):
  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);

  Uint8List? _markerBytes;

  Location? getRiderLocation(String id){
    return _riderLocations[id];
  }


  @override
  void onInit() {
    loadMarkers();
    super.onInit();
  }


  void loadMarkers(){
    var context=Get.context!;
    var media=MediaQuery.of(context);
    _dropoff_marker=BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    getBytesFromAsset(AssetPath.ICON_CUR_LOC2,
        (45*media.devicePixelRatio).toInt()).then((value) {
      _markerBytes = value as Uint8List;
    });
  }



  Future<List<int>> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      // targetWidth: width,
      targetHeight: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    ByteData? image = await fi.image.toByteData(format: ui.ImageByteFormat.png);
    return image!.buffer.asUint8List();
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