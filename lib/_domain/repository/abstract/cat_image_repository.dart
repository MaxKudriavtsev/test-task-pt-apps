import 'package:test_task_pt_appps/_data/models/cat_image_model.dart';

abstract class CatImageRepository {
  Future<List<CatImageModel>> fetchCats();
}
