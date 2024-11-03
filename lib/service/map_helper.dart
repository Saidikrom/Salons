import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salons/service/custom_marker_helper.dart';

class MapHelper {
  final Completer<GoogleMapController> controller;
  final Set<Marker> markers;

  MapHelper(this.controller, this.markers);

  Future<void> createCustomMarker(double rating, LatLng latLng, String markerId,
      Function() updateUI,String name) async {
    final Uint8List markerIcon = await createCustomMarkerWithText(
      '$rating',
      'assets/icons/location_icon.png',
    );
    markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: latLng,
        icon: BitmapDescriptor.fromBytes(markerIcon),
        infoWindow: InfoWindow(title: name),
      ),
    );
    updateUI();
  }

  Future<void> getCurrentLocation(
      BuildContext context, Function(LatLng) onLocationFound) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng currentLocation = LatLng(position.latitude, position.longitude);

  final Uint8List currentIcon = await createCustomMarkerWithText(
      '',
      'assets/icons/current_icon.png',
    );
    markers.add(
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: currentLocation,
        icon: BitmapDescriptor.fromBytes(currentIcon),
      ),
    );

    onLocationFound(currentLocation);

    final GoogleMapController mapController = await controller.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 15),
      ),
    );
  }

  Future<void> requestLocationPermission(Function onPermissionGranted) async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      onPermissionGranted();
    } else if (status.isDenied) {
      print("Location permission denied");
    } else if (status.isPermanentlyDenied) {
      print("Location permission permanently denied");
      openAppSettings();
    }
  }
}
