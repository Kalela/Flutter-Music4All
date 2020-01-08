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

  @override
  void initState() {
    getEditorPicks().then((value) {
      setState(() {
        _editorAlbums.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 250,
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
          ],
        ),
      ),
    );
  }
}