import 'package:flutter/material.dart';
import 'package:musicforall_app/util/globalappconstants.dart';

class FeaturedPlaylistsPage extends StatefulWidget {
  final List<dynamic> _featuredPlaylists;

  FeaturedPlaylistsPage(this._featuredPlaylists);

  @override
  _FeaturedPlaylistsPageState createState() => _FeaturedPlaylistsPageState(_featuredPlaylists);


}

class _FeaturedPlaylistsPageState extends State<FeaturedPlaylistsPage> {
  List<dynamic> _featuredPlaylists;

  _FeaturedPlaylistsPageState(this._featuredPlaylists);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalAppConstants.appBackgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: GridView.builder(
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
          scrollDirection: Axis.vertical,
          itemCount: _featuredPlaylists.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2, crossAxisSpacing: 2),
        ),
      ),
    );
  }
}
