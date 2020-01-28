import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:musicforall_app/util/loaders/loader.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => new _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {

  List<Song> _songs;
  MusicFinder audioPlayer;

  @override
  initState() {
    super.initState();
    audioPlayer = new MusicFinder();
    fetchSongs().then((value){
      setState(() {
        _songs.addAll(value);
      });
    });
  }

  Future<List<Song>> fetchSongs() async {
    List<Song> songs;
    try {
      songs = await MusicFinder.allSongs();
    } catch(e) {
      print(e.toString());
    }

    if (songs.isNotEmpty) {
      _songs.addAll(songs);
//      audioPlayer.play(songs.first.uri);
    }

    return songs;
  }

  @override
  void dispose() {
    audioPlayer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if(_songs != null) {
      child = Material(
          child: Scaffold(
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 240,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    width: 160,
                    child: Card(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            title: Text(_songs[index].title),
                            subtitle:
                            Text(_songs[index].artist),
                          )
                        ],
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.vertical,
                itemCount: _songs.length,
              ),
            ),
          )
      );
    } else {
      child = Material(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Searching for music...",
                  style: TextStyle(fontSize: 24, fontFamily: 'Montesserat'),),
                Loader()
              ],
            )
          )
        ),
      );
    }
    return child;
  }
}