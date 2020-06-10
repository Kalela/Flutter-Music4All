import 'package:flute_music_player/flute_music_player.dart';

class EditorPicksAction {
  final List<dynamic> payload;

  EditorPicksAction(this.payload);

}

class UserAlbumsAction {
  final List<dynamic> payload;

  UserAlbumsAction(this.payload);

}

class FeaturedPlaylistsAction {
  final List<dynamic> payload;

  FeaturedPlaylistsAction(this.payload);

}

class SongsAction {
  final List<Song> payload;

  SongsAction(this.payload);

}

class PlayerStateAction {
  final dynamic payload;

  PlayerStateAction(this.payload);
}