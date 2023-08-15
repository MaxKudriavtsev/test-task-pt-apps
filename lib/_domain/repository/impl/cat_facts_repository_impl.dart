import 'package:test_task_pt_appps/_data/data_source/abstract/cat_facts_data_source.dart';
import 'package:test_task_pt_appps/_data/models/cat_fact_model.dart';
import 'package:test_task_pt_appps/_domain/repository/abstract/cat_facts_repository.dart';

class CatFactsRepositoryImpl implements CatFactsRepository {
  final CatFactsDataSource _catFactsDataSource;

  CatFactsRepositoryImpl(this._catFactsDataSource);

  @override
  Future<List<CatFact>> fetchCatFact() {
    return _catFactsDataSource.fetchCatFacts();
  }
}
