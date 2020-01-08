

import 'package:musicforall_app/entities/albumlink.dart';

class Album {
  String id;
  String upc;
  String shortcut;
  String href;
  String name;
  String released;
  String originallyReleased;
  String label;
  String copyright;
  List<String> tags;
  bool isExplicit;
  AlbumLink link;
  String artistName;
  String albumImageUrl;

  Album(this.id, this.upc, this.shortcut,
      this.href, this.name, this.released,
      this.originallyReleased, this.label,
      this.copyright, this.tags,
      this.isExplicit, this.link,
      this.artistName, this.albumImageUrl);

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    upc = json['upc'];
    shortcut = json['shortcut'];
    href = json['href'];
    name = json['name'];
    released = json['released'];
    originallyReleased = json['originallyReleased'];
    label = json['label'];
    copyright = json['copyright'];
    tags = json['tags'];
    isExplicit = json['isExplicit'];
    link = json['links'];
    artistName = json['artistName'];
  }
}