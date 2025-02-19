import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:povedi_me_app/constants/styles/app_colors.dart';
import 'package:povedi_me_app/constants/styles/text.dart';
import 'package:povedi_me_app/models/place.dart';
import 'package:povedi_me_app/services/place_details_service.dart';
import 'package:povedi_me_app/widgets/custom_app_bar.dart';
import 'package:povedi_me_app/widgets/working_hours_place.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({
    super.key,
    this.placeLatitude,
    this.placeLongitude,
    this.isFromPlace = false,
    this.place,
  });

  final double? placeLatitude;
  final double? placeLongitude;
  final bool isFromPlace;
  final Place? place;

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Location _locationController = Location();
  final Completer<GoogleMapController> _googleMapController = Completer();

  static const _defaultLocation = LatLng(46.163182, 16.831360);
  LatLng? _pickedLocation;
  LatLng? _currentPosition = null;
  bool _trafficEnabled = false;
  String placeName = "Trenutna lokacija";
  String? workingHours;
  bool? openNow;
  bool isLoadingWorkingHours = true;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    if (widget.placeLatitude != null && widget.placeLongitude != null) {
      _pickedLocation = LatLng(widget.placeLatitude!, widget.placeLongitude!);
    }
    if (widget.place != null) {
      placeName = widget.place!.title;
      fetchDetails();
    }
    // .then(
    //   (_) => {
    //     getPolylinePoints().then(
    //       (coordinates) => {
    //         generatePolyLineFromPoints(
    //           coordinates,
    //         )
    //       },
    //     )
    //   },
    // );
  }

  void fetchDetails() async {
    final String placeName = widget.place!.title.trim();

    setState(() {
      isLoadingWorkingHours = true;
    });

    final details = await ref
        .read(placeDetailsServiceProvider)
        .fetchPlaceDetails(placeName: placeName);

    setState(() {
      workingHours = details['workingHours'];
      openNow = details['openNow'];
      isLoadingWorkingHours = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFromPlace
          ? AppBar(
              leading: CustomAppBar(
                onBack: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          : null,
      body: Stack(
        children: [
          _currentPosition == null
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.lightBlue),
                )
              : GoogleMap(
                  onMapCreated: (controller) {
                    _googleMapController.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _pickedLocation ?? _defaultLocation,
                    zoom: 16,
                  ),
                  markers: _getMarkers(),
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
        backgroundColor: AppColors.lightBlue,
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

  Set<Marker> _getMarkers() {
    Set<Marker> markers = {};

    if (_currentPosition != null) {
      markers.add(_buildCurrentLocationMarker());
    }
    if (_pickedLocation != null) {
      markers.add(_buildPickedLocationMarker());
    }

    return markers;
  }

  Marker _buildCurrentLocationMarker() {
    return Marker(
      markerId: const MarkerId('current_location'),
      position: _currentPosition!,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: "Trenutna lokacija"),
    );
  }

  Marker _buildPickedLocationMarker() {
    return Marker(
      markerId: const MarkerId('picked_location'),
      position: _pickedLocation!,
      infoWindow: InfoWindow(
        title: placeName,
        snippet: 'Kliknite za detalje o trenutnoj lokaciji',
        onTap: () {
          debugPrint('Trenutna lokacija info prozor kliknut!');
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      placeName,
                      style: AppTextStyles.categoryHeadline(context),
                    ),
                    const SizedBox(height: 8.0),
                    WorkingHoursPlace(
                      workingHours: workingHours ??
                          "Nema dostupnih podataka o radnom vremenu.",
                      openNow: openNow ?? false,
                      isLoadingWorkingHours: isLoadingWorkingHours,
                      isShop: false,
                      isMap: true,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _googleMapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
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
          if (mounted) {
            setState(
              () {
                _currentPosition =
                    LatLng(locationData.latitude!, locationData.longitude!);
                //_cameraToPosition(_currentPosition!);
              },
            );
          }
        }
      },
    );
  }

  // Future<List<LatLng>> getPolylinePoints() async {
  //   List<LatLng> polylineCoordinates = [];
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   final request = PolylineRequest(
  //     origin: PointLatLng(
  //       _currentPosition!.latitude,
  //       _currentPosition!.longitude,
  //     ),
  //     destination: PointLatLng(
  //       _pickedLocation!.latitude,
  //       _pickedLocation!.longitude,
  //     ),
  //     mode: TravelMode.driving,
  //   );
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     request: request,
  //     googleApiKey: "AIzaSyBE1s72xyeMR07GgEuz_TsGDX-a58KS-tY",
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach(
  //       (PointLatLng point) {
  //         polylineCoordinates.add(
  //           LatLng(
  //             point.latitude,
  //             point.longitude,
  //           ),
  //         );
  //       },
  //     );
  //   } else {
  //     print(result.errorMessage);
  //   }

  //   return polylineCoordinates;
  // }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: AppColors.darkBlue,
        width: 5,
        points: polylineCoordinates);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
