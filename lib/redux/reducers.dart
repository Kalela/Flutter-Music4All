import 'package:musicforall_app/entities/app_state.dart';
import 'package:musicforall_app/redux/actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  switch (action) {
    case EditorPicksAction:
      newState.editorAlbums = action.payload;
      break;
    case UserAlbumsAction:
      newState.userAlbums = action.payload;
      break;
    case SongsAction:
      newState.songs = action.payload;
      break;
    case FeaturedPlaylistsAction:
      newState.playlists = action.payload;
      break;
    case PlayerStateAction:
      newState.playerState = action.payload;
      break;
  }
  return newState;
}