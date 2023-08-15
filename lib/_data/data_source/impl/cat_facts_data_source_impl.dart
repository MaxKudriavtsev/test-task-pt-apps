import 'dart:convert';

import 'package:test_task_pt_appps/_data/data_source/abstract/cat_facts_data_source.dart';
import 'package:test_task_pt_appps/_data/models/cat_fact_model.dart';
import 'package:http/http.dart' as http;

class CatFactsDataSourceImpl implements CatFactsDataSource {
  @override
  Future<List<CatFact>> fetchCatFacts() async {
    final response = await http.get(Uri.parse('https://catfact.ninja/facts'));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((fact) => CatFact.fromJson(fact)).toList();
    } else {
      throw Exception('Failed to load cat facts');
    }
  }
}
