import 'package:test_task_pt_appps/_data/data_source/abstract/cat_image_data_source.dart';
import 'package:test_task_pt_appps/_data/models/cat_image_model.dart';
import 'package:test_task_pt_appps/_domain/repository/abstract/cat_image_repository.dart';

class CatImageRepositoryImpl implements CatImageRepository {
  final CatImageDataSource _catImageDataSource;

  CatImageRepositoryImpl(this._catImageDataSource);
  @override
  Future<List<CatImageModel>> fetchCats() {
    return _catImageDataSource.fetchCats();
  }
}
