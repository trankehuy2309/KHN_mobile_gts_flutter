import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class OMapPage extends StatefulWidget {
  const OMapPage({Key? key}) : super(key: key);

  @override
  _OMapPageState createState() => _OMapPageState();
}

class _OMapPageState extends State<OMapPage>
    with SingleTickerProviderStateMixin {
  late MapZoomPanBehavior _zoomPanBehavior;
  MapTileLayerController? _mapController;
  AnimationController? _animationController;
  late Animation<double> _animation;
  late List<_RouteDetails> _routes;
  int _currentSelectedCityIndex = 0;
  late String _routeJson;

  @override
  void initState() {
    _routeJson = 'assets/london_to_british.json';
    _routes = <_RouteDetails>[
      _RouteDetails(const MapLatLng(51.4700, -0.4543), null, 'London Heathrow'),
      _RouteDetails(
          const MapLatLng(51.5194, -0.1270),
          Icon(Icons.location_on, color: Colors.red[600], size: 30),
          'The British Museum'),
    ];
    _mapController = MapTileLayerController();
    _zoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 3,
      zoomLevel: 10,
      focalLatLng: const MapLatLng(51.4700, -0.2843),
      toolbarSettings: const MapToolbarSettings(
          direction: Axis.vertical, position: MapToolbarPosition.bottomRight),
      maxZoomLevel: 15,
      enableDoubleTapZooming: true,
    );

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _animationController = null;
    _mapController?.dispose();
    _mapController = null;
    _routes.clear();
    super.dispose();
  }

  Future<dynamic> getJsonData() async {
    final List<MapLatLng> polyline = <MapLatLng>[];
    final String data = await rootBundle.loadString(_routeJson);
    final dynamic jsonData = json.decode(data);
    final List<dynamic> polylinePoints =
        jsonData['features'][0]['geometry']['coordinates'] as List<dynamic>;
    for (int i = 0; i < polylinePoints.length; i++) {
      polyline.add(MapLatLng(polylinePoints[i][1], polylinePoints[i][0]));
    }
    // ignore: unawaited_futures
    _animationController?.forward(from: 0);

    return polyline;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getJsonData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapdata) {
          if (snapdata.hasData) {
            final List<MapLatLng> polylinePoints =
                snapdata.data as List<MapLatLng>;
            return Stack(children: <Widget>[
              SfMaps(
                layers: <MapLayer>[
                  MapTileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    initialMarkersCount: _routes.length,
                    controller: _mapController,
                    markerBuilder: (BuildContext context, int index) {
                      if (_routes[index].icon != null) {
                        return MapMarker(
                          key: UniqueKey(),
                          latitude: _routes[index].latLan.latitude,
                          longitude: _routes[index].latLan.longitude,
                          alignment: Alignment.bottomCenter,
                          child: _routes[index].icon,
                        );
                      } else {
                        return MapMarker(
                          key: UniqueKey(),
                          latitude: _routes[index].latLan.latitude,
                          longitude: _routes[index].latLan.longitude,
                          iconType: MapIconType.circle,
                          iconColor: Colors.white,
                          iconStrokeWidth: 2.0,
                          size: const Size(15, 15),
                          iconStrokeColor: Colors.black,
                        );
                      }
                    },
                    tooltipSettings: const MapTooltipSettings(
                      color: Color.fromRGBO(45, 45, 45, 1),
                    ),
                    markerTooltipBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _routes[index].city,
                          ));
                    },
                    sublayers: <MapSublayer>[
                      MapPolylineLayer(
                          polylines: <MapPolyline>{
                            MapPolyline(
                              points: polylinePoints,
                              color: const Color.fromRGBO(0, 102, 255, 1.0),
                              width: 6.0,
                            )
                          },
                          animation: _animation,
                          tooltipBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _routes[0].city + ' - ' + _routes[1].city,
                              ),
                            );
                          }),
                    ],
                    zoomPanBehavior: _zoomPanBehavior,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildChipWidget(0, 'The British Museum'),
                      _buildChipWidget(1, 'The Windsor Castle'),
                      _buildChipWidget(2, 'Twickenham Stadium'),
                      _buildChipWidget(3, 'Chessington World of Adventures'),
                      _buildChipWidget(4, 'Hampton Court Palace'),
                    ],
                  ),
                ),
              )
            ]);
          } else {
            return Container();
          }
        });
  }

  Widget _buildChipWidget(int index, String city) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ChoiceChip(
        backgroundColor: Colors.white,
        elevation: 3.0,
        label: Text(
          city,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        selected: _currentSelectedCityIndex == index,
        onSelected: (bool isSelected) {
          if (isSelected) {
            setState(() {
              _currentSelectedCityIndex = index;
              _currentNavigationLine(index, city);
            });
          }
        },
      ),
    );
  }

  void _currentNavigationLine(int index, String city) {
    switch (index) {
      case 0:
        setState(() {
          _routeJson = 'assets/london_to_british.json';
          _zoomPanBehavior.focalLatLng = const MapLatLng(51.4700, -0.2843);
          _zoomPanBehavior.zoomLevel = 10;
          _routes[1] = _RouteDetails(const MapLatLng(51.5194, -0.1270),
              Icon(Icons.location_on, color: Colors.red[600], size: 30), city);
          _mapController!.updateMarkers(<int>[1]);
        });
        break;
    }
  }
}

class _RouteDetails {
  _RouteDetails(this.latLan, this.icon, this.city);

  MapLatLng latLan;
  Widget? icon;
  String city;
}
