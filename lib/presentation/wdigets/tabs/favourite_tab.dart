import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_event.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_state.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  void initState() {
    super.initState();
    context.read<CatBloc>().add(LoadFavouritesEvent(subId: 'default_sub_id'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatBloc, CatState>(
      builder: (context, state) {
        if (state is CatLoaded && state.favourites.isNotEmpty) {
          return ListView.builder(
            itemCount: state.favourites.length,
            itemBuilder: (context, index) {
              final favourite = state.favourites[index];
              return ListTile(
                leading: Image.network(favourite.image.url),
                trailing: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    context.read<CatBloc>().add(
                        RemoveFromFavouritesEvent(favouriteId: favourite.id));
                  },
                ),
              );
            },
          );
        } else if (state is CatError) {
          return Center(
              child: Text('Error occured while trying to upload data'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
