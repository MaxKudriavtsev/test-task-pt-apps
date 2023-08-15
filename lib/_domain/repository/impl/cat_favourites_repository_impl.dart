import 'package:test_task_pt_appps/_data/data_source/abstract/cat_favoutires_data_source.dart';
import 'package:test_task_pt_appps/_data/models/cat_favourites_model.dart';
import 'package:test_task_pt_appps/_domain/repository/abstract/cat_favourites_repository.dart';

class CatFavouritesRepositoryImpl implements CatFavouritesRepository {
  final CatFavouritesDataSource _catFavouritesDataSource;

  CatFavouritesRepositoryImpl(this._catFavouritesDataSource);
  @override
  Future<List<CatFavouriteModel>> getFavorites({
    required String subId,
    int limit = 20,
  }) {
    return _catFavouritesDataSource.getFavorites(
      subId: subId,
      limit: limit,
    );
  }

  @override
  Future<void> addToFavorites(String imageId, {String? subId}) {
    return _catFavouritesDataSource.addToFavorites(imageId);
  }

  @override
  Future<void> removeFromFavorites(int favouriteId) {
    return _catFavouritesDataSource.removeFromFavorites(favouriteId);
  }
}
