import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salons/core/constants/urls_const.dart';
import 'package:salons/models/map_suggetion_model.dart';

class SearchRepository {
  Future<MapSuggestionModel> fetchPlaceSuggestions(String input) async {
    final url = Uri.parse(
        '${UrlsConst.autocomplete_url}?input=$input&key=${UrlsConst.apiKey}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return MapSuggestionModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch suggestions: ${data['status']}');
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
