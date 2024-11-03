import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salons/logic/bloc/salons_bloc/salons_bloc.dart';
import 'package:salons/models/salon_model.dart';

Widget mainBottomSheetWidget(Function currentLocation) {
  return DraggableScrollableSheet(
    minChildSize: 0.13,
    initialChildSize: .5,
    maxChildSize: 1,
    builder: (BuildContext context, ScrollController scrollController) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 40,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          height: MediaQuery.of(context).size.height * 0.5,
          child: SingleChildScrollView(
            controller: scrollController,
            child: BlocBuilder<SalonsBloc, SalonsState>(
              builder: (context, state) {
                if (state is SalonsInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SalonsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SalonsLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${state.salons.meta.total} salons near you",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              currentLocation();
                            },
                            child: Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xffEAEAEA),
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/current_icon.svg",
                                width: 40,
                                height: 40,
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: state.salons.data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                salonImage(
                                  context,
                                  state.salons,
                                  index,
                                ),
                                detailInfo(
                                  state.salons,
                                  index,
                                ),
                                distanceReview(
                                  state.salons,
                                  index,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                if (state is SalonsError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return const Center(
                    child: Text('Error'),
                  );
                }
              },
            ),
          ),
        ),
      );
    },
  );
}

Widget salonImage(BuildContext context, SalonsModel state, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 18),
    height: 190,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: NetworkImage(
          state.data[index].backgroundImg,
        ),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(12),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.65),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xffF0F0F0),
            ),
          ),
          child: Center(
            child: Text(
              state.data[index].rAvg == null
                  ? "0"
                  : state.data[index].rAvg.toString(),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget detailInfo(SalonsModel state, int index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.data[index].translation.title.length >= 25
                ? "${state.data[index].translation.title.substring(0, 25)}..."
                : state.data[index].translation.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            state.data[index].translation.address.length >= 30
                ? "${state.data[index].translation.address.substring(0, 30)}..."
                : state.data[index].translation.address,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xffA0A09C),
            ),
          ),
        ],
      ),
      const SizedBox(width: 10),
      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.65),
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(state.data[index].logoImg),
          ),
        ),
      ),
    ],
  );
}

Widget distanceReview(SalonsModel state, int index) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            SvgPicture.asset("assets/icons/near_icon.svg"),
            const SizedBox(width: 5),
            Text(
              "${state.data[index].distance} km. from you",
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xffA0A09C),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            const Text(
              "Excellent",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(
                Icons.circle,
                size: 5,
              ),
            ),
            Text(
              state.data[index].rCount == null
                  ? "0 reviews"
                  : "${state.data[index].rCount} reviews",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 1,
        color: const Color(0xffEAEAEA),
      ),
    ],
  );
}
