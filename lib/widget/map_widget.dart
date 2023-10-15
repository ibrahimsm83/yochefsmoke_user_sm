import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {

  final bool myLocationEnabled;
  final CameraPosition initialCameraPosition;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final void Function(GoogleMapController controller)? onMapCreated;
  final void Function(CameraPosition pos)? onCameraMove;
  final bool scrollGesturesEnabled,rotateGesturesEnabled,zoomGesturesEnabled;
  const MapWidget({Key? key,this.myLocationEnabled=true,this.onMapCreated,
    this.onCameraMove,
    this.scrollGesturesEnabled=true,this.rotateGesturesEnabled=true,
    this.zoomGesturesEnabled=true,
    required this.initialCameraPosition,this.markers=const {},this.polylines=const {}})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      compassEnabled: false,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled:myLocationEnabled,
      mapType: MapType.normal,
      onMapCreated: onMapCreated,
      markers:markers,
      polylines: polylines,
      onCameraMove: onCameraMove,
      scrollGesturesEnabled: scrollGesturesEnabled,
      rotateGesturesEnabled: rotateGesturesEnabled,
      zoomGesturesEnabled: zoomGesturesEnabled,

    );
  }
}
