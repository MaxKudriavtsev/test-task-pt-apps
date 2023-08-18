import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_pt_appps/_data/data_source/impl/cat_facts_data_source_impl.dart';
import 'package:test_task_pt_appps/_data/data_source/impl/cat_favourites_data_source_impl.dart';
import 'package:test_task_pt_appps/_data/data_source/impl/cat_image_data_source_impl.dart';
import 'package:test_task_pt_appps/_domain/repository/impl/cat_facts_repository_impl.dart';
import 'package:test_task_pt_appps/_domain/repository/impl/cat_favourites_repository_impl.dart';
import 'package:test_task_pt_appps/_domain/repository/impl/cat_image_repository_impl.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/cat_bloc/cat_event.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_bloc.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_event.dart';
import 'package:test_task_pt_appps/buisness_logic/blocs/profile_bloc/profile_state.dart';
import 'package:test_task_pt_appps/presentation/wdigets/tabs/cat_tab.dart';
import 'package:test_task_pt_appps/presentation/wdigets/tabs/favourite_tab.dart';
import 'package:test_task_pt_appps/presentation/wdigets/tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late final ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _profileBloc = ProfileBloc(
      BlocProvider.of<AuthenticationBloc>(context),
    );
    _profileBloc.add(LoadProfile());
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>.value(value: _profileBloc),
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileState) {
          final String? subId = (profileState is ProfileLoaded)
              ? profileState.user.email
              : 'default_sub_id';
          return Scaffold(
            appBar: AppBar(
              title: Text("Cats App"),
              bottom: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: "Cats"),
                  Tab(text: "Favorites"),
                  Tab(text: "Profile"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                BlocProvider<CatBloc>(
                  create: (context) => CatBloc(
                    catImageRepository: CatImageRepositoryImpl(
                      CatImageDataSourceImpl(),
                    ),
                    catFactRepository: CatFactsRepositoryImpl(
                      CatFactsDataSourceImpl(),
                    ),
                    catFavouritesRepository: CatFavouritesRepositoryImpl(
                      CatFavoritesDataSourceImpl(),
                    ),
                    subId: subId!,
                  ),
                  child: CatsTab(),
                ),
                BlocProvider<CatBloc>(
                  create: (context) => CatBloc(
                    catFactRepository:
                        CatFactsRepositoryImpl(CatFactsDataSourceImpl()),
                    catFavouritesRepository: CatFavouritesRepositoryImpl(
                      CatFavoritesDataSourceImpl(),
                    ),
                    catImageRepository: CatImageRepositoryImpl(
                      CatImageDataSourceImpl(),
                    ),
                    subId: subId!,
                  ),
                  child: BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileLoaded) {
                        final subId = state.user.email;
                        context.read<CatBloc>().add(UpdateSubId(subId: subId!));
                      }
                    },
                    child: FavoritesTab(),
                  ),
                ),
                ProfileTab(),
              ],
            ),
          );
        },
      ),
    );
  }
}
