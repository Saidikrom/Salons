import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salons/logic/bloc/salons_bloc/salons_bloc.dart';
import 'package:salons/widgets/bottom_sheet_widget.dart';
import 'package:salons/widgets/widgets.dart';
import '../../service/map_helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.34824258342502, 69.23908778931946),
    zoom: 13,
  );

  Set<Marker> markers = {};
  late LatLng currentLocation;
  late MapHelper mapHelper;

  @override
  void initState() {
    super.initState();
    mapHelper = MapHelper(_controller, markers);
    mapHelper.requestLocationPermission(() {
      mapHelper.getCurrentLocation(context, (LatLng location) {
        setState(() {
          currentLocation = location;
        });
        context.read<SalonsBloc>().add(
              GetNearSalons(location.latitude, location.longitude),
            );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: BlocListener<SalonsBloc, SalonsState>(
          listener: (context, state) {
            if (state is SalonsLoaded) {
              for (var salon in state.salons.data) {
                setState(() {
                  mapHelper.createCustomMarker(
                    salon.rAvg ?? 0.0,
                    LatLng(salon.latLong.latitude, salon.latLong.longitude),
                    salon.id.toString(),
                    () {
                      setState(() {});
                      // Ensure setState is called to refresh the UI
                    },
                    salon.translation.title,
                  );
                });
              }
            }
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              topElelment(context, _controller),
              mainBottomSheetWidget(() {
                mapHelper.getCurrentLocation(context, (LatLng location) {
                  setState(() {
                    currentLocation = location;
                  });
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
