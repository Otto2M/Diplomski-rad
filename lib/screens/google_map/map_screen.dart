import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Location _locationController = Location();
  final Completer<GoogleMapController> _googleMapController = Completer();

  static const _defaultLocation = LatLng(46.163182, 16.831360);
  LatLng? _pickedLocation;
  LatLng? _currentPosition = null;
  bool _trafficEnabled = false;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then(
      (_) => {
        getPolylinePoints().then(
          (coordinates) => {
            generatePolyLineFromPoints(
              coordinates,
            )
          },
        )
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentPosition == null
              ? const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryLight),
                )
              : GoogleMap(
                  onMapCreated: (controller) {
                    _googleMapController.complete(controller);
                  },
                  initialCameraPosition: const CameraPosition(
                    target: _defaultLocation,
                    zoom: 16,
                  ),
                  markers: {
                    if (_currentPosition != null)
                      Marker(
                        markerId: const MarkerId('current_location'),
                        position: _currentPosition!,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue),
                        infoWindow:
                            const InfoWindow(title: "Trenutna lokacija"),
                      ),
                    if (_pickedLocation != null)
                      Marker(
                        markerId: const MarkerId('picked_location'),
                        position: _pickedLocation!,
                        infoWindow: InfoWindow(
                          title: 'Trenutna lokacija',
                          snippet: 'Detalji o trenutnoj lokaciji',
                          onTap: () {
                            print('Trenutna lokacija info prozor kliknut!');
                          },
                        ),
                      ),
                  },
                  polylines: Set<Polyline>.of(polylines.values),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  trafficEnabled: _trafficEnabled,
                  onTap: (position) {
                    setState(() {
                      _pickedLocation = position;
                    });
                  },
                ),
          Positioned(
            top: 40,
            left: 10,
            child: Switch(
              value: _trafficEnabled,
              onChanged: (value) {
                setState(() {
                  _trafficEnabled = value;
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryLight,
        onPressed: () async {
          if (_currentPosition != null) {
            GoogleMapController controller = await _googleMapController.future;
            controller.animateCamera(
              CameraUpdate.newLatLng(_currentPosition!),
            );
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _googleMapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  //get location
  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen(
      (LocationData locationData) {
        if (locationData.latitude != null && locationData.longitude != null) {
          setState(
            () {
              _currentPosition =
                  LatLng(locationData.latitude!, locationData.longitude!);
              _cameraToPosition(_currentPosition!);
            },
          );
        }
      },
    );
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    final request = PolylineRequest(
      origin: PointLatLng(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      ),
      destination: PointLatLng(
        _pickedLocation!.latitude,
        _pickedLocation!.longitude,
      ),
      mode: TravelMode.driving,
    );
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: request,
      googleApiKey: "AIzaSyBE1s72xyeMR07GgEuz_TsGDX-a58KS-tY",
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) {
          polylineCoordinates.add(
            LatLng(
              point.latitude,
              point.longitude,
            ),
          );
        },
      );
    } else {
      print(result.errorMessage);
    }

    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: AppColors.accentLight,
        width: 5,
        points: polylineCoordinates);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
