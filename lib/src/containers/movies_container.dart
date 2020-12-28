import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:GAD2020/src/models/movie.dart';
import 'package:GAD2020/src/models/app_state.dart';
// ignore: implementation_imports
import 'package:redux/src/store.dart';

class MoviesContainer extends StatelessWidget {
  const MoviesContainer({Key key, @required this.builder}) : super(key: key);

  final ViewModelBuilder<List<Movie>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Movie>>(
      converter: (Store<AppState> store) => store.state.movies.asList(),
      builder: builder,
    );
  }
}
