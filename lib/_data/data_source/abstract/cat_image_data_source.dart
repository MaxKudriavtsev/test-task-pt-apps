import 'package:test_task_pt_appps/_data/models/cat_image_model.dart';

abstract class CatImageDataSource {
  Future<List<CatImageModel>> fetchCats();
}
