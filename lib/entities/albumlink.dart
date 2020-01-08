import 'package:musicforall_app/entities/albumimages.dart';

class AlbumLink {
  AlbumImage albumImage;

  AlbumLink(this.albumImage);

  AlbumLink.fromJson(Map<String, dynamic> json) {
    albumImage = json['images'];
  }
}