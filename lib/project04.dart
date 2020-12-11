import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Center(
            child: Text(
              "Movies",
            ),
          ),
        ),
        body: MovieStateFull(),
      ),
    );
  }
}

class Movie {
  String title, image, url, backgroundImage;
  double rating;
  List<String> genres;

  Movie(String title, String image, String backgroundImage, double rating, List<String> genres, String url) {
    this.title = title;
    this.image = image;
    this.backgroundImage = backgroundImage;
    this.rating = rating;
    this.genres = genres;
    this.url = url;
  }
}

class MovieStateFull extends StatefulWidget {
  //const MovieStateFull({Key key}) : super(key: key);

  @override
  _MovieStateFullState createState() => _MovieStateFullState();
}

class _MovieStateFullState extends State<MovieStateFull> {
  List<Movie> _movies, _allMovies;
  String _dropdownValue = 'None';
  List<String> _allGenres = new List<String>();

  Future<void> getMovies() async {
    final Response response = await get("https://yts.mx/api/v2/list_movies.json?limit=50");
    Map<String, dynamic> json = jsonDecode(response.body);

    _allMovies = List<Movie>();
    for (int i = 0; i < json['data']['limit']; i++) {
      String _title = json['data']['movies'][i]['title'];
      String _image = json['data']['movies'][i]['large_cover_image'];
      String _background = json['data']['movies'][i]['background_image'];
      double _rating;
      _rating = json['data']['movies'][i]['rating'].toDouble();
      List<dynamic> _auxGenres = json['data']['movies'][i]['genres'];
      List<String> _genres = _auxGenres.cast<String>().toList();
      for (int j = 0; j < _genres.length; j++) {
        if (!_allGenres.contains(_genres[j])) {
          _allGenres.add(_genres[j]);
        }
      }
      String _url = json['data']['movies'][i]['url'];
      _allMovies.add(new Movie(_title, _image, _background, _rating, _genres, _url));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _allGenres.add('None');
      _allGenres.add('Rating Ascending');
      _allGenres.add('Rating Descending');
      getMovies();
    });
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        //for refreshing the list
        _movies = _allMovies;
      });
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void filter(String filterChoice) {
    setState(() {
      if (filterChoice.contains('Rating')) {
        if (filterChoice.contains('Ascending')) {
          _movies = _allMovies.toList();
          _movies.sort((a, b) => a.rating.compareTo(b.rating));
        } else {
          _movies = _allMovies.toList();
          _movies.sort((a, b) => b.rating.compareTo(a.rating));
        }
      } else if (filterChoice != 'None') {
        _movies = _allMovies.where((element) => element.genres.contains(filterChoice)).toList();
      } else {
        _movies = _allMovies;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          DropdownButton<String>(
            value: _dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                _dropdownValue = newValue;
                filter(_dropdownValue);
              });
            },
            items: _allGenres.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          GridView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: _movies == null ? 20 : _movies.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(4.0),
                color: Colors.black12,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    _movies == null
                        ? CircularProgressIndicator()
                        : Image.network(
                            _movies[index].backgroundImage,
                            fit: BoxFit.fitHeight,
                          ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            _movies == null ? "Loading.." : _movies[index].title,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.blueGrey,
                              backgroundColor: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: _movies == null
                                ? CircularProgressIndicator()
                                : Image.network(
                                    _movies[index].image,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        _launchURL(_movies == null ? "" : _movies[index].url);
                      },
                      child: null,
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
