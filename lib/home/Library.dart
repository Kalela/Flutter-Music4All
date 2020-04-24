import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:musicforall_app/entities/app_state.dart';
import 'package:musicforall_app/redux/actions.dart';
import 'package:musicforall_app/util/globalappconstants.dart';
import 'package:musicforall_app/util/loaders/loader.dart';
import 'package:musicforall_app/util/now_playing_footer.dart';
import 'package:permission/permission.dart';

import '../play_state.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => new _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {

  String nowPlayingSong = "";
  String nowPlayingArtist = "";

  Duration duration;
  Duration position;

  List<Song> _songs = [];
  MusicFinder audioPlayer;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  @override
  initState() {
    super.initState();
    audioPlayer = new MusicFinder();
    if (_songs.isEmpty) {
      fetchSongs().then((value){
        StoreProvider.of<AppState>(context)
            .dispatch(SongsAction(value));
        setState(() {
          _songs.addAll(value);
        });
      });
    }
  }

  Future<List<Song>> fetchSongs() async {
    List<Song> songs;
    var permissions = await Permission.getPermissionsStatus([PermissionName.Storage, PermissionName.Camera]);

    var permissionNames = await Permission.requestPermissions([PermissionName.Storage, PermissionName.Camera]);

    Permission.openSettings;

    try {
      songs = await MusicFinder.allSongs();
    } catch(e) {
      print(e.toString() + "I errored here");
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

  play(String kUrl) async {
    final result = await audioPlayer.play(kUrl);
    if (result == 1) setState(() => playerState = PlayerState.playing);
  }

// add a isLocal parameter to play a local file
  playLocal(String kUrl) async {
    final result = await audioPlayer.play(kUrl);
    if (result == 1) setState(() => playerState = PlayerState.playing);
  }


  pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => playerState = PlayerState.paused);
  }

  stop() async {
    final result = await audioPlayer.stop();
    if (result == 1) setState(() => playerState = PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if(_songs.isNotEmpty) {
      child = Scaffold(
            backgroundColor: GlobalAppConstants.appBackgroundColor,
            body: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Tracks")
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: 160,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              if (playerState == PlayerState.playing) {
                                stop();
                              }
                              playLocal(_songs[index].uri);
                              setNowPlaying(_songs[index]);
                            },
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  title: Text(_songs[index].title),
                                  subtitle:
                                  Text(_songs[index].artist),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: _songs.length,
                  ),
                ),
                NowPlayingFooter(Colors.white, nowPlayingSong, nowPlayingArtist, playerState)
              ],
            )
      );
    } else {
      child = Scaffold(
          backgroundColor: GlobalAppConstants.appBackgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Searching for music...",
                  style: TextStyle(fontSize: 24, fontFamily: 'Montesserat'),),
//                Loader()
              ],
            )
          )
      );
    }
    return child;
  }

  Widget setNowPlaying(Song song) {
    nowPlayingArtist = song.artist;
    nowPlayingSong = song.title;
  }
}