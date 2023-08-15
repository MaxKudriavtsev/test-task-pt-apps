import 'dart:convert';

import 'package:test_task_pt_appps/_data/data_source/abstract/cat_image_data_source.dart';
import 'package:test_task_pt_appps/_data/models/cat_image_model.dart';
import 'package:http/http.dart' as http;

class CatImageDataSourceImpl implements CatImageDataSource {
  @override
  Future<List<CatImageModel>> fetchCats() async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10'),
    );
    final List<dynamic> jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return jsonResponse
          .map((catJson) => CatImageModel.fromJson(catJson))
          .toList();
    } else {
      throw Exception('Failed to load cat data');
    }
  }
}
