import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salons/core/constants/urls_const.dart';

import '../../models/place_details_model.dart';

class PlaceDetailsRepository {
  static Future<PlaceDetailsModel?> fetchPlaceDetails(String placeId) async {
    final String url =
        '${UrlsConst.placeDetails_url}?place_id=$placeId&key=${UrlsConst.apiKey}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          return PlaceDetailsModel.fromJson(data);
        } else {
          print('Error: ${data['status']}');
        }
      } else {
        print(
            'Failed to load place details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching place details: $e');
    }
    return null;
  }
}
