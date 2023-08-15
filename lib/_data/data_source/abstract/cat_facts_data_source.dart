import 'package:test_task_pt_appps/_data/models/cat_fact_model.dart';

abstract class CatFactsDataSource {
  Future<List<CatFact>> fetchCatFacts();
}
