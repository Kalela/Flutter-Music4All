import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:musicforall_app/globalappconstants.dart';



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

    http.Response response = await http
        .get(
          Uri.encodeFull('http://api.napster.com/v2.2/albums/picks'),
          headers: {
          'apikey':GlobalAppConstants.apiKey,
            'Accept': 'application/json'
          }
        );

    if (response.statusCode == 200) {
      var editorsChoiceResponse = json.decode(response.body);
      albums = editorsChoiceResponse['albums'];
    }
    return albums;
  }

  Future<List<dynamic>> getFeaturedPlaylists() async {
    List<dynamic> playlists = new List<dynamic>();

    http.Response response = await http
        .get(
        Uri.encodeFull('http://api.napster.com/v2.2/playlists/featured?limit=5'),
        headers: {
          'apikey':GlobalAppConstants.apiKey,
          'Accept': 'application/json'
        }
    );

    if (response.statusCode == 200) {
      var editorsChoiceResponse = json.decode(response.body);
      playlists = editorsChoiceResponse['playlists'];
    }
    return playlists;
  }

  @override
  void initState() {
    getEditorPicks().then((value) {
      setState(() {
        _editorAlbums.addAll(value);
      });
    });

    getFeaturedPlaylists().then((value) {
      setState(() {
        _featuredPlaylists.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: Center(
        child: Column(
          children: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Editor's Album Picks",
                  style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.white,
                    fontFamily: 'Montesserat'
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 40.0,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 240,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return
                  Container(
                    width: 160,
                    child: Card(
                      child: Wrap(
                        children: <Widget>[
                          Image.network("https://api.napster.com/imageserver/v2/albums/${_editorAlbums[index]['id']}/images/500x500.jpg"),
                          ListTile(
                            title: Text(_editorAlbums[index]['name']),
                            subtitle: Text(_editorAlbums[index]['artistName']),
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
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Featured Playlists",
                  style: TextStyle(
                      fontSize: 36.0,
                      color: Colors.white,
                      fontFamily: 'Montesserat'
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 40.0,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return
                    Container(
                      width: 160,
                      child: Card(
                        child: Wrap(
                          children: <Widget>[
                            Image.network("https://api.napster.com/imageserver/v2/playlists/${_featuredPlaylists[index]['id']}/artists/images/500x500.jpg"),
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
          ],
        ),
      ),
    );
  }
}