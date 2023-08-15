import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_task_pt_appps/_data/data_source/abstract/cat_favoutires_data_source.dart';
import 'package:test_task_pt_appps/_data/models/cat_favourites_model.dart';

class CatFavoritesDataSourceImpl implements CatFavouritesDataSource {
  final String apiKey =
      'live_RFlCwSfL9JQu37ieBImUAVbkNeM09ZmgDTaL10aIDJLD9tLDfOW09r1ROBWGQtOw';
  final String baseUrl = 'https://api.thecatapi.com/v1';

  @override
  Future<List<CatFavouriteModel>> getFavorites({
    required String subId,
    int limit = 20,
  }) async {
    final Uri uri =
        Uri.parse('$baseUrl/favourites?limit=$limit&sub_id=$subId&order=DESC');
    final response = await http.get(
      uri,
      headers: {
        "content-type": "application/json",
        'x-api-key': apiKey,
      },
    );
    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => CatFavouriteModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch favorites');
    }
  }

  @override
  Future<CatFavouriteModel> addToFavorites(String imageId,
      {String? subId}) async {
    final Uri uri = Uri.parse('$baseUrl/favourites');
    final response = await http.post(
      uri,
      headers: {
        "content-type": "application/json",
        'x-api-key': apiKey,
      },
      body: jsonEncode({
        'image_id': imageId,
        if (subId != null) 'sub_id': subId,
      }),
    );

    if (response.statusCode == 200) {
      return CatFavouriteModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add to favorites');
    }
  }

  @override
  Future<void> removeFromFavorites(int favouriteId) async {
    final Uri uri = Uri.parse('$baseUrl/favourites/$favouriteId');
    final response = await http.delete(
      uri,
      headers: {
        "content-type": "application/json",
        'x-api-key': apiKey,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove from favorites');
    }
  }
}
