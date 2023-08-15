import 'package:test_task_pt_appps/_data/models/cat_favourites_model.dart';

abstract class CatFavouritesDataSource {
  Future<List<CatFavouriteModel>> getFavorites({
    required String subId,
    int limit = 20,
  });
  Future<CatFavouriteModel> addToFavorites(String imageId, {String? subId});
  Future<void> removeFromFavorites(int favouriteId);
}
