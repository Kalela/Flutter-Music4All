import 'package:flutter/material.dart';
import 'package:musicforall_app/util/globalappconstants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlbumPage extends StatefulWidget {
  final String albumId;
  final String albumImage;

  AlbumPage(this.albumId, this.albumImage);

  @override
  _AlbumPageState createState() => _AlbumPageState(albumId, albumImage);
}

class _AlbumPageState extends State<AlbumPage> {
  List<dynamic> _tracks;
  String albumId;
  String albumImage;

  _AlbumPageState(this.albumId, this.albumImage);

  Future<List<dynamic>> getAlbumTracks() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            'http://api.napster.com/v2.2/albums/picks/${albumId}/tracks'),
        headers: {
          'apikey': GlobalAppConstants.apiKey,
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      var editorsChoiceResponse = json.decode(response.body);
      _tracks = editorsChoiceResponse['albums'];
    }
    return _tracks;
  }

  @override
  void initState() {
    getAlbumTracks().then((value) {
      setState(() {
        _tracks.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalAppConstants.appBackgroundColor,
      body: Center(
          child: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: Text('Now Playing'),
          backgroundColor: Colors.blueGrey,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              albumImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ])),
    );
  }
}
