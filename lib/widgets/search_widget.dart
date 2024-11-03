// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:salons/logic/bloc/search_bloc/search_state.dart';

import '../logic/bloc/salons_bloc/salons_bloc.dart';
import '../logic/bloc/search_bloc/search_bloc.dart';
import '../logic/bloc/search_bloc/search_event.dart';
import '../logic/repositories/place_details_repository.dart';
import '../logic/repositories/search_repository.dart';

class SearchWidget extends StatefulWidget {
  final Completer<GoogleMapController> mapController;
  const SearchWidget({
    super.key,
    required this.mapController,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController textController = TextEditingController();
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(searchRepository: SearchRepository()),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 1,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      searchField(context, textController),
                      BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is SearchLoaded) {
                            final suggestions = state.suggestions;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: suggestions.predictions.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    final placeDetails =
                                        await PlaceDetailsRepository
                                            .fetchPlaceDetails(suggestions
                                                .predictions[index].placeId);
                                    final LatLng targetLatLng = LatLng(
                                      placeDetails?.result!.geometry!.location!
                                          .lat as double,
                                      placeDetails?.result!.geometry!.location!
                                          .lng as double,
                                    );
                                    final GoogleMapController controller =
                                        await widget.mapController.future;
                                    controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: targetLatLng, zoom: 15),
                                      ),
                                    );
                                    context.read<SalonsBloc>().add(
                                          GetNearSalons(targetLatLng.latitude,
                                              targetLatLng.longitude),
                                        );

                                    Navigator.pop(context);
                                  },
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            icon:
                                                const Icon(Icons.location_pin),
                                            onPressed: () {
                                              textController.text = suggestions
                                                  .predictions[index]
                                                  .description;
                                            },
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                suggestions
                                                            .predictions[index]
                                                            .description
                                                            .length >
                                                        25
                                                    ? "${suggestions.predictions[index].description.substring(0, 25)}..."
                                                    : suggestions
                                                        .predictions[index]
                                                        .description,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              suggestions
                                                          .predictions[index]
                                                          .structuredFormatting
                                                          .secondaryText ==
                                                      null
                                                  ? const SizedBox()
                                                  : Text(suggestions
                                                              .predictions[
                                                                  index]
                                                              .structuredFormatting
                                                              .secondaryText!
                                                              .length >
                                                          25
                                                      ? "${suggestions.predictions[index].structuredFormatting.secondaryText!.substring(0, 25)}..."
                                                      : suggestions
                                                          .predictions[index]
                                                          .structuredFormatting
                                                          .secondaryText!),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else if (state is SearchError) {
                            return Center(child: Text(state.message));
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget searchField(BuildContext context, TextEditingController textController) {
  return TextFormField(
    onChanged: (text) {
      context.read<SearchBloc>().add(SearchTextChanged(text));
    },
    style: const TextStyle(fontSize: 16),
    textInputAction: TextInputAction.search,
    controller: textController,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        color: const Color(0xffEAEAEA),
        icon: const Icon(Icons.clear),
        onPressed: () {
          textController.clear();
        },
      ),
      prefixIcon: const Icon(
        Icons.location_on_rounded,
        color: Color.fromARGB(255, 184, 183, 183),
      ),
      contentPadding: const EdgeInsets.only(left: 20),
      fillColor: Colors.white,
      filled: true,
      hintText: "Search",
      hintStyle: const TextStyle(
        color: Color.fromARGB(255, 180, 180, 180),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xffEAEAEA),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xffEAEAEA),
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xffEAEAEA),
        ),
      ),
    ),
  );
}
