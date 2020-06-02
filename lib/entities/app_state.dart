

import 'package:musicforall_app/util/globalappconstants.dart';

class AppState {
  List<dynamic> playlists;
  List<dynamic> editorAlbums;
  List<dynamic> userAlbums;
  List<dynamic> songs;
  PlayerState playerState;

  AppState({this.playlists, this.editorAlbums, this.userAlbums, this.songs, this.playerState});

  AppState.fromAppState(AppState another) {
    playlists = another.playlists;
    editorAlbums = another.editorAlbums;
    userAlbums = another.userAlbums;
    songs = another.songs;
    playerState = another.playerState;
  }


}