import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:musicforall_app/entities/app_state.dart';
import 'package:musicforall_app/redux/actions.dart';
import 'package:musicforall_app/util/functions.dart';

import 'package:musicforall_app/util/globalappconstants.dart';
import 'package:musicforall_app/util/widgets.dart';
import 'package:musicforall_app/views/internal_pages/playlists/editors_picks_page.dart';
import 'package:musicforall_app/views/internal_pages/playlists/featured_playlist_page.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return StatefulWrapper(
          onInit: () {
            if (state.editorAlbums == null) {
              getEditorPicks().then((value) {
                StoreProvider.of<AppState>(context)
                    .dispatch(EditorPicksAction(value));
              });
            }

            if (state.editorAlbums == null) {
              getFeaturedPlaylists().then((value) {
                StoreProvider.of<AppState>(context)
                    .dispatch(FeaturedPlaylistsAction(value));
              });
            }
          },
          child: Scaffold(
            backgroundColor: GlobalAppConstants.appBackgroundColor,
            body: Center(
                child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Text('Now Playing'),
                  backgroundColor: Colors.blueGrey,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRK_8e-Ne7KyqYZwJv32JH9XQm0SlG3kX_JdawE-j3VlTSTF5TNA&s',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Ink(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditorsPickPage(state.editorAlbums)));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Editor's Album Picks",
                              style: TextStyle(
                                  fontSize: 34.0,
                                  color: Colors.white,
                                  fontFamily: 'Montesserat'),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 40.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 240,
                      child: state.editorAlbums != null
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 160,
                                  child: Card(
                                    child: Wrap(
                                      children: <Widget>[
                                        Image.network(
                                            "https://api.napster.com/imageserver/v2/albums/${state.editorAlbums[index]['id']}/images/500x500.jpg"),
                                        ListTile(
                                          title: Text(state.editorAlbums[index]
                                              ['name']),
                                          subtitle: Text(
                                              state.editorAlbums[index]
                                                  ['artistName']),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: state.editorAlbums.length,
                            )
                          : Container(),
                    ),
                    Ink(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeaturedPlaylistsPage(
                                      state.featuredPlaylists)));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Featured Playlists",
                              style: TextStyle(
                                  fontSize: 34.0,
                                  color: Colors.white,
                                  fontFamily: 'Montesserat'),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 40.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 200,
                      child: state.featuredPlaylists != null
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 160,
                                  child: Card(
                                    child: Wrap(
                                      children: <Widget>[
                                        Image.network(
                                            "https://api.napster.com/imageserver/v2/playlists/${state.featuredPlaylists[index]['id']}/artists/images/500x500.jpg"),
                                        ListTile(
                                          title: Text(
                                              state.featuredPlaylists[index]
                                                  ['name']),
//                              subtitle: Text(_featuredPlaylists[index]['artistName']),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: state.featuredPlaylists.length,
                            )
                          : Container(),
                    ),
                  ]),
                )
              ],
            )),
          ),
        );
      },
    );
  }
}


