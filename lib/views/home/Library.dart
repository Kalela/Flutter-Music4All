import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:musicforall_app/entities/app_state.dart';
import 'package:musicforall_app/redux/actions.dart';
import 'package:musicforall_app/util/globalappconstants.dart';
import 'package:musicforall_app/util/widgets.dart';
import 'package:permission/permission.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class LibraryPage extends StatelessWidget {
  String nowPlayingSong = "";
  String nowPlayingArtist = "";

  Duration duration;
  Duration position;

  MusicFinder audioPlayer;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';
  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  Future<Database> databaseSetup() async {
    final Future<Database> database = openDatabase(
      path.join(await getDatabasesPath(), 'doggie_database.db'),
    );

    return database;
  }

  Future<List<Song>> fetchSongs() async {
    List<Song> songs;
    var permissions = await Permission.getPermissionsStatus(
        [PermissionName.Storage, PermissionName.Camera]);

    var permissionNames = await Permission.requestPermissions(
        [PermissionName.Storage, PermissionName.Camera]);

    Permission.openSettings;

    try {
      songs = await MusicFinder.allSongs();
    } catch (e) {
      print(e.toString() + "I errored here");
    }

    return songs;
  }

  play(String kUrl, BuildContext context) async {
    final result = await audioPlayer.play(kUrl);
    if (result == 1) StoreProvider.of<AppState>(context)
          .dispatch(PlayerStateAction(PlayerState.playing));
  }

// add a isLocal parameter to play a local file
  playLocal(String kUrl, BuildContext context) async {
    final result = await audioPlayer.play(kUrl);
    if (result == 1) StoreProvider.of<AppState>(context)
          .dispatch(PlayerStateAction(PlayerState.playing));
  }

  pause(BuildContext context) async {
    final result = await audioPlayer.pause();
    if (result == 1) StoreProvider.of<AppState>(context)
          .dispatch(PlayerStateAction(PlayerState.paused));
  }

  stop(BuildContext context) async {
    final result = await audioPlayer.stop();
    if (result == 1)
      StoreProvider.of<AppState>(context)
          .dispatch(PlayerStateAction(PlayerState.stopped));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return StatefulWrapper(
            onInit: () {
              audioPlayer = new MusicFinder();
              if (state.songs == null) {
                databaseSetup().then((value) {
                  fetchSongs().then((value) {
                    StoreProvider.of<AppState>(context)
                        .dispatch(SongsAction(value));
                        print("I am here $value");
                  });
                });
              }
            },
            child: state.songs != null
                ? Scaffold(
                    backgroundColor: GlobalAppConstants.appBackgroundColor,
                    body: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[Text("Tracks")],
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
                                        stop(context);
                                      }
                                      playLocal(state.songs[index].uri, context);
                                      setNowPlaying(state.songs[index]);
                                    },
                                    child: Wrap(
                                      children: <Widget>[
                                        ListTile(
                                          title: Text(state.songs[index].title),
                                          subtitle: Text(state.songs[index].artist),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            scrollDirection: Axis.vertical,
                            itemCount: state.songs.length,
                          ),
                        ),
                        showNowPlayingFooter(Colors.white, nowPlayingSong,
                            nowPlayingArtist, playerState),
                      ],
                    ))
                : Scaffold(
                    backgroundColor: GlobalAppConstants.appBackgroundColor,
                    body: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Searching for music...",
                          style: TextStyle(
                              fontSize: 24, fontFamily: 'Montesserat'),
                        ),
                      ],
                    ))),
          );
        });
  }

  Widget setNowPlaying(Song song) {
    nowPlayingArtist = song.artist;
    nowPlayingSong = song.title;
  }
}
