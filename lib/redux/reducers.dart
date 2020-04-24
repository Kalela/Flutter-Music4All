import 'package:musicforall_app/entities/app_state.dart';
import 'package:musicforall_app/redux/actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is EditorAlbumsAction) {
    newState.editorAlbums = action.payload;
  }
  else if (action is UserAlbumsAction) {
    newState.userAlbums = action.payload;
  }
  else if (action is SongsAction) {
    newState.songs = action.payload;
  }
  else if (action is PlaylistsAction) {
    newState.playlists = action.payload;
  }
  else if (action is PlayerStateAction) {
    newState.playerState = action.payload;
  }

  return newState;
}