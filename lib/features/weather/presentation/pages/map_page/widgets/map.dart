import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:globalweather/core/network/api_constants.dart';
import 'package:latlong2/latlong.dart';

class AppMap extends StatelessWidget {
  final MapController mapController;
  final LatLng selectedPoint;
  final Function(LatLng) onPointSelected;

  const AppMap({
    super.key,
    required this.mapController,
    required this.selectedPoint,
    required this.onPointSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: selectedPoint,
        initialZoom: 9.0,
        onTap: (tapPosition, point) {
          onPointSelected(point);
        },
      ),
      children: [
        TileLayer(
          urlTemplate: ApiConstants.osmUrl,
          userAgentPackageName: 'com.globalweather.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: selectedPoint,
              width: 60,
              height: 60,
              child: const Icon(
                Icons.location_on,
                color: Colors.redAccent,
                size: 40,
                shadows: [Shadow(blurRadius: 10, color: Colors.black45)],
              ),
            ),
          ],
        ),
      ],
    );
  }
}