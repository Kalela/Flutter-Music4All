import 'dart:convert';

import 'package:http/http.dart' as http;

import 'globalappconstants.dart';

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
      Uri.encodeFull('http://api.napster.com/v2.2/playlists/featured?limit=5'),
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
