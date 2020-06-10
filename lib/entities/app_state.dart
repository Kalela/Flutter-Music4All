

import 'package:musicforall_app/util/globalappconstants.dart';
import 'package:flute_music_player/flute_music_player.dart';

class AppState {
  List<dynamic> playlists;
  List<dynamic> featuredPlaylists;
  List<dynamic> editorAlbums;
  List<dynamic> userAlbums;
  List<Song> songs = new List<Song>();
  PlayerState playerState;

  AppState({this.playerState});

  AppState.fromAppState(AppState another) {
    playlists = another.playlists;
    editorAlbums = another.editorAlbums;
    userAlbums = another.userAlbums;
    songs = another.songs;
    playerState = another.playerState;
    featuredPlaylists = another.featuredPlaylists;
  }


}