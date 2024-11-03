import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salons/widgets/search_widget.dart';

TextEditingController textController = TextEditingController();

Widget zoomInOut(VoidCallback zoomIn, VoidCallback zoomOut) {
  return Positioned(
    bottom: 150,
    right: 20,
    child: Column(
      children: [
        FloatingActionButton(
          onPressed: zoomIn,
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: zoomOut,
          child: const Icon(Icons.remove),
        ),
      ],
    ),
  );
}

Widget topElelment(context, Completer<GoogleMapController> controller) {
 return GestureDetector(
    onTap: () {
      _searchScrollableSheet(context, controller);
    },
    child: Container(
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
      ),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff000000).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 25,
              offset: const Offset(0, 0),
            ),
          ]),
      child: SvgPicture.asset(
        "assets/icons/search_icon.svg",
        width: 50,
        height: 50,
        fit: BoxFit.none,
      ),
    ),
  );
}

bool isSearch = false;
void _searchScrollableSheet(
    BuildContext context, Completer<GoogleMapController> _controller) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SearchWidget(mapController: _controller);
    },
  );
}

Widget currentLocation(Future<void> onCurrentLocation) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      margin: const EdgeInsets.only(right: 10, top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
      child: IconButton(
        icon: const Icon(
          Icons.my_location,
          color: Colors.black,
        ),
        onPressed: () {
          onCurrentLocation;
        },
      ),
    ),
  );
}
