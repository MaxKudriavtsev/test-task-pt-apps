import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_event.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_state.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_state.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileBloc>().state;

    if (profileState is ProfileLoaded) {
      context
          .read<CatBloc>()
          .add(LoadFavouritesEvent(subId: profileState.user.email!));
    }

    return BlocBuilder<CatBloc, CatState>(
      builder: (context, state) {
        if (state is CatEmptyFavorites) {
          return Center(child: Text('No favorites added yet.'));
        } else if (state is CatLoaded && state.favourites.isNotEmpty) {
          return ListView.builder(
            itemCount: state.favourites.length,
            itemBuilder: (context, index) {
              final favourite = state.favourites[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 150.0,
                      height: 200.0,
                      margin: const EdgeInsets.only(right: 16.0),
                      child: Image.network(
                        favourite.image!.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Favourite Cat'),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context.read<CatBloc>().add(RemoveFromFavouritesEvent(
                              favouriteId: favourite.id,
                            ));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is CatError) {
          return Center(
              child: Text('Error occurred while trying to upload data'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
