import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salons/core/constants/urls_const.dart';
import 'package:salons/models/salon_model.dart';

class SalonsRepository {
  Future<SalonsModel> fetchPlaceSuggestions(double lat, double lon) async {
    final url = Uri.parse(
        '${UrlsConst.salons_url}page=1&lang=en&location_type=2&column=distance&sort=asc&address%5Blatitude%5D=$lat&address%5Blongitude%5D=$lon');

    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
     
        return SalonsModel.fromJson(data);
     
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
