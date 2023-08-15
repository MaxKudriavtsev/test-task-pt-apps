import 'package:test_task_pt_appps/_data/models/cat_fact_model.dart';
import 'package:test_task_pt_appps/_data/models/cat_favourites_model.dart';
import 'package:test_task_pt_appps/_data/models/cat_image_model.dart';

abstract class CatState {}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final List<CatImageModel> cats;
  final bool appendToCurrentList;
  final List<CatFact> catFacts;
  final List<CatFavouriteModel> favourites;

  CatLoaded({
    required this.cats,
    this.appendToCurrentList = false,
    required this.catFacts,
    required this.favourites,
  });
}

class CatEmptyFavorites extends CatState {}

class CatError extends CatState {}
