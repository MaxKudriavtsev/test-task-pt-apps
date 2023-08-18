abstract class CatEvent {}

class FetchCats extends CatEvent {
  final bool appendToExisting;
  final bool showLoadingIndicator;

  FetchCats({this.appendToExisting = false, this.showLoadingIndicator = true});
}

class RemoveFromFavorites extends CatEvent {}

class AddToFavouritesEvent extends CatEvent {
  final String imageId;
  final String subId;

  AddToFavouritesEvent({required this.imageId, required this.subId});
}

class RemoveFromFavouritesEvent extends CatEvent {
  final int favouriteId;

  RemoveFromFavouritesEvent({required this.favouriteId});
}

class LoadFavouritesEvent extends CatEvent {
  final String subId;

  LoadFavouritesEvent({required this.subId});
}

class UpdateSubId extends CatEvent {
  final String subId;
  UpdateSubId({required this.subId});
}
