import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:musicforall_app/entities/app_state.dart';
import 'package:musicforall_app/redux/actions.dart';
import 'package:musicforall_app/util/globalappconstants.dart';
import 'package:musicforall_app/views/internal_pages/playlists/editors_picks_page.dart';
import 'package:musicforall_app/views/internal_pages/playlists/featured_playlist_page.dart';

class DiscoverPage extends StatefulWidget {
  DiscoverPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<dynamic> _editorAlbums = new List<dynamic>();
  List<dynamic> _featuredPlaylists = new List<dynamic>();

  Future<List<dynamic>> getEditorPicks() async {
    List<dynamic> albums = new List<dynamic>();

    http.Response response = await http.get(
        Uri.encodeFull('http://api.napster.com/v2.2/albums/picks'),
        headers: {
          'apikey': GlobalAppConstants.apiKey,
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      var editorsChoiceResponse = json.decode(response.body);
      albums = editorsChoiceResponse['albums'];
    }
    return albums;
  }

  Future<List<dynamic>> getFeaturedPlaylists() async {
    List<dynamic> playlists = new List<dynamic>();

    http.Response response = await http.get(
        Uri.encodeFull(
            'http://api.napster.com/v2.2/playlists/featured?limit=5'),
        headers: {
          'apikey': GlobalAppConstants.apiKey,
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      var editorsChoiceResponse = json.decode(response.body);
      playlists = editorsChoiceResponse['playlists'];
    }
    return playlists;
  }

  @override
  void initState() {
    if (_editorAlbums.isEmpty) {
      getEditorPicks().then((value) {
        StoreProvider.of<AppState>(context)
            .dispatch(EditorAlbumsAction(value));
        setState(() {
          _editorAlbums.addAll(value);
        });
      });
    }

    if (_featuredPlaylists.isEmpty) {
      getFeaturedPlaylists().then((value) {
        StoreProvider.of<AppState>(context)
            .dispatch(PlaylistsAction(value));
        setState(() {
          _featuredPlaylists.addAll(value);
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EditorsPickPage(_editorAlbums)
                  ));
                },
                color: Color(0xFF2d3447),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 240,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      width: 160,
                      child: Card(
                        child: Wrap(
                          children: <Widget>[
                            Image.network(
                                "https://api.napster.com/imageserver/v2/albums/${_editorAlbums[index]['id']}/images/500x500.jpg"),
                            ListTile(
                              title: Text(_editorAlbums[index]['name']),
                              subtitle:
                                  Text(_editorAlbums[index]['artistName']),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: _editorAlbums.length,
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FeaturedPlaylistsPage(_featuredPlaylists)
                  ));
                },
                color: Color(0xFF2d3447),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 200,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      width: 160,
                      child: Card(
                        child: Wrap(
                          children: <Widget>[
                            Image.network(
                                "https://api.napster.com/imageserver/v2/playlists/${_featuredPlaylists[index]['id']}/artists/images/500x500.jpg"),
                            ListTile(
                              title: Text(_featuredPlaylists[index]['name']),
//                              subtitle: Text(_featuredPlaylists[index]['artistName']),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: _featuredPlaylists.length,
                ),
              ),
            ]),
          )
        ],
      )
      ),
    );
  }
}
