import 'package:test_task_pt_appps/_data/data_source/impl/cat_favourites_data_source_impl.dart';
import 'package:test_task_pt_appps/_data/models/cat_favourites_model.dart';

abstract class CatFavouritesRepository {
  CatFavouritesRepository(
      CatFavoritesDataSourceImpl catFavoritesDataSourceImpl);

  Future<List<CatFavouriteModel>> getFavorites({
    required String subId,
    int limit = 20,
  });
  Future<void> addToFavorites({required String imageId, required String subId});
  Future<void> removeFromFavorites(int favouriteId);
}
