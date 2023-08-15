import 'package:bloc/bloc.dart';
import 'package:test_task_pt_appps/_domain/repository/abstract/cat_facts_repository.dart';
import 'package:test_task_pt_appps/_domain/repository/abstract/cat_favourites_repository.dart';
import 'package:test_task_pt_appps/_domain/repository/abstract/cat_image_repository.dart';
import 'cat_event.dart';
import 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatImageRepository catImageRepository;
  final CatFactsRepository catFactRepository;
  final CatFavouritesRepository catFavouritesRepository;
  final String subId;

  CatBloc({
    required this.catImageRepository,
    required this.catFactRepository,
    required this.catFavouritesRepository,
    required this.subId,
  }) : super(CatInitial()) {
    print('$subId');
    on<FetchCats>((event, emit) async {
      if (event.showLoadingIndicator) {
        emit(CatLoading());
      }
      try {
        final catImages = await catImageRepository.fetchCats();
        final catFacts = await catFactRepository.fetchCatFact();
        final catFavourites = await catFavouritesRepository.getFavorites(
          subId: subId,
        );

        if (event.appendToExisting && state is CatLoaded) {
          emit(CatLoaded(
              cats: (state as CatLoaded).cats + catImages,
              favourites: (state as CatLoaded).favourites + catFavourites,
              appendToCurrentList: true,
              catFacts: (state as CatLoaded).catFacts + catFacts));
        } else {
          emit(CatLoaded(
              cats: catImages, favourites: catFavourites, catFacts: catFacts));
        }
      } catch (error) {
        emit(CatError());
      }
    });

    on<AddToFavouritesEvent>((event, emit) async {
      try {
        await catFavouritesRepository.addToFavorites(event.imageId,
            subId: event.subId);

        final updatedFavourites = await catFavouritesRepository.getFavorites(
          subId: event.subId,
        );

        if (state is CatLoaded) {
          emit(CatLoaded(
            cats: (state as CatLoaded).cats,
            catFacts: (state as CatLoaded).catFacts,
            favourites: updatedFavourites,
          ));
        }
      } catch (error) {
        emit(CatError());
      }
    });

    on<RemoveFromFavouritesEvent>((event, emit) async {
      try {
        await catFavouritesRepository.removeFromFavorites(event.favouriteId);
        final updatedFavourites = await catFavouritesRepository.getFavorites(
          subId: subId,
        );

        if (state is CatLoaded) {
          emit(CatLoaded(
            cats: (state as CatLoaded).cats,
            catFacts: (state as CatLoaded).catFacts,
            favourites: updatedFavourites,
          ));
        }
      } catch (error) {
        emit(CatError());
      }
    });

    on<LoadFavouritesEvent>((event, emit) async {
      try {
        final favourites =
            await catFavouritesRepository.getFavorites(subId: event.subId);
        if (favourites.isEmpty) {
          emit(CatEmptyFavorites());
        } else {
          emit(
            CatLoaded(cats: [], catFacts: [], favourites: favourites),
          );
        }
      } catch (error) {
        emit(CatError());
      }
    });
  }
}
