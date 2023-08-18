import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_event.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_state.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_state.dart';

class CatsTab extends StatefulWidget {
  @override
  _CatsTabState createState() => _CatsTabState();
}

class _CatsTabState extends State<CatsTab> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<CatBloc>().add(
          FetchCats(showLoadingIndicator: true),
        );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<CatBloc>().add(
            FetchCats(appendToExisting: true, showLoadingIndicator: false),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatBloc, CatState>(
      builder: (context, state) {
        if (state is CatLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CatLoaded) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.cats.length,
            itemBuilder: (context, index) {
              final cat = state.cats[index];
              final catFact = state.catFacts[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 150.0,
                      height: 200.0,
                      margin: const EdgeInsets.only(right: 16.0),
                      child: Image.network(
                        cat.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(catFact.fact),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        (state)
                                .favourites
                                .any((favourite) => favourite.imageId == cat.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      onPressed: () {
                        final profileState = context.read<ProfileBloc>().state;

                        if (profileState is ProfileLoaded) {
                          final userEmail = profileState.user.email;

                          if ((state).favourites.any(
                              (favourite) => favourite.imageId == cat.id)) {
                            final favouriteId = (state)
                                .favourites
                                .firstWhere(
                                    (favourite) => favourite.imageId == cat.id)
                                .id;
                            context.read<CatBloc>().add(
                                  RemoveFromFavouritesEvent(
                                    favouriteId: favouriteId,
                                  ),
                                );
                          } else {
                            context.read<CatBloc>().add(
                                  AddToFavouritesEvent(
                                    imageId: cat.id,
                                    subId: userEmail!,
                                  ),
                                );
                          }
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is CatError) {
          return Center(
              child: Text('Error occured while trying to download info'));
        } else {
          return Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}
