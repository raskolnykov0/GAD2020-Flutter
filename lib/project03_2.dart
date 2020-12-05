import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text("Traduction!"),
          ),
        ),
        body: SoundStateFull(),
      ),
    );
  }
}

class SoundStateFull extends StatefulWidget {
  @override
  _SoundStateFullState createState() => _SoundStateFullState();
}

class _SoundStateFullState extends State<SoundStateFull> {
  ///vars
  AudioPlayer _audioPlayer = AudioPlayer();
  AudioCache _audioCache = AudioCache();
  bool _isPlaying = false;

  List<String> paths = new List();
  List<String> names = new List();

  ///#vars

  ///methods
  void initState() {
    super.initState();
    paths.addAll([
      "Buna ziua.mp3",
      "Ciao.mp3",
      "Ce mai faceti.mp3",
      "Cosa stai facendo.mp3",
      "Unde este gara.mp3",
      "Dove si trova la stazione ferroviaria.mp3",
      "Vrei sa bei bere.mp3",
      "Vuoi bere birra.mp3"
    ]);
    names.addAll([
      "Buna ziua",
      "Ciao",
      "Ce mai faceti",
      "Cosa stai facendo",
      "Unde este gara",
      "Dove si trova la stazione ferroviaria",
      "Vrei sa bei bere",
      "Vuoi bere birra"
    ]);
  }

  void playSound(String path) async {
    if (_isPlaying == true) {
      _audioPlayer.stop();
    }
    _audioPlayer = await _audioCache.play(path);
    _isPlaying = true;
  }

  ///#methods

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(5),
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.teal,
                  width: 0.4,
                ),
                color: Colors.teal),
            child: FlatButton(
              onPressed: () {
                setState(
                  () {
                    playSound(paths[index]);
                  },
                );
              },
              child: Text(
                names[index],
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
